import logging
from typing import Dict, Tuple, Optional

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from gensim.models import Word2Vec
import gensim.downloader
from keras.callbacks import EarlyStopping

from pandas import Series
from sklearn.manifold import TSNE, MDS, SpectralEmbedding
from stellargraph import StellarDiGraph
from stellargraph.data import UnsupervisedSampler, BiasedRandomWalk, SampledBreadthFirstWalk
from stellargraph.layer import GraphSAGE, link_classification
from stellargraph.mapper import GraphSAGELinkGenerator
from stellargraph.mapper import GraphSAGENodeGenerator
from tensorflow import keras

from categorization import TitleClassification
from colorLogger import configure_logging
from neo4jconnector import Neo4JLocalConnector


class GraphSAGEConfig(object):
    # Sampling
    WALKS = 15
    LENGTH_OF_WALK = 8
    # data generation
    BATCH_SIZE = 36
    NUM_SAMPLES = [12, 6]


class UnsupervisedGraphSAGE(object):

    def __init__(self):
        # Connection
        self.uri = "bolt://localhost:7687"

        configure_logging(logging.INFO)
        self.logger = logging.getLogger(str(type(self)))

        self.classifier = None

    def create_embeddings(self, graph: StellarDiGraph, node_subjects: Series, random=False) -> Dict[str, np.ndarray]:
        # TODO: use the edge descriptors also in the walks
        walk_creator = self._create_walks_with_title if random else self._create_walks_with_title_from_subgraphs
        self.logger.info("Using: {} for walks".format(walk_creator))
        walks = walk_creator(graph, node_subjects)
        self.logger.info("found: {} walks".format(len(walks)))

        model = Word2Vec(walks, vector_size=128, window=3, min_count=0, sg=1, ns_exponent=0.75, workers=5, epochs=50,
                         alpha=0.005, min_alpha=0.0001, sample=1e-4)

        node_titles = model.wv.index_to_key
        node_embeddings = (
            model.wv.vectors
        )
        self.logger.info("graph length is {}, embedding vocabulary is size {}".format(
            len(node_subjects), len(node_titles))
        )
        # build a dictionary with node_ids as key and node embeddings as value and
        # get all node titles that are not embedded
        node_ids_embeddings = {}
        not_in_embedding = []
        for key, (value, _) in node_subjects.items():
            try:
                idx = node_titles.index(value)
                node_ids_embeddings[key] = node_embeddings[idx]
            except ValueError:
                not_in_embedding.append(value)
        assert len(not_in_embedding) == 0, 'Embeddings not created for: {}'.format(not_in_embedding)

        # visualize
        self._plot_node_embeddings(node_embeddings, node_titles)

        return node_ids_embeddings

    def _plot_node_embeddings(self, node_embeddings, node_titles):
        self.logger.info("node Embeddings: %s, node_titles: %s" % (node_embeddings.shape, len(node_titles)))

        transform = TSNE
        trans = transform(n_components=2)
        node_embeddings_2d = trans.fit_transform(node_embeddings)

        self._plot_embedding_scatter(
            data=(node_embeddings_2d[:, 0], node_embeddings_2d[:, 1]),
            c=self._retrieve_node_colours_corresponding_to_classes(node_titles),
            alpha=0.7,
            legend_alpha=0.5,
            legend_loc="lower left",
            title="2D visualization of Node2Vec embeddings using {}".format(transform.__name__),
            activate_title=False
        )

    def _plot_embedding_scatter(
            self, data, c, alpha=0.7, legend_alpha=0.5, legend_loc="lower right", title="", activate_title=True,
            text_on_nodes=False
    ):
        _, ax = plt.subplots(figsize=(10, 10))
        scatter = ax.scatter(
            data[0],
            data[1],
            c=c,
            cmap='jet',
            alpha=alpha,
        )
        # classes legend
        handles, _ = scatter.legend_elements(alpha=legend_alpha)
        classes_sorted = pd.Series(self.classifier.class_ids).sort_values().index
        legend = ax.legend(handles,
                           classes_sorted,
                           scatterpoints=1,
                           scatteryoffsets=[0.5],
                           numpoints=1,
                           ncols=1,
                           bbox_to_anchor=(0, 1.),
                           fontsize=8,
                           loc=legend_loc,
                           frameon=False,
                           columnspacing=0.1,
                           labelspacing=0.2,
                           edgecolor='white',)
        ax.add_artist(legend)
        plt.subplots_adjust(top=0.6)
        ax.set(aspect="equal")
        if activate_title:
            plt.title(title)
        # plot text labels to points
        if text_on_nodes != None:
            for idx, node_id in enumerate(text_on_nodes):
                plt.text(data[0][idx], data[1][idx], node_id, fontsize=8, ha="right", va="center")
        plt.show()

    def _retrieve_node_colours_corresponding_to_classes(self, node_titles):
        if not self.classifier:
            self.classifier = TitleClassification()
        # builds a list of numbers according to target class membership
        # we build a list that corresponds to all node titles in retrieving first their class, and then the
        # corresponding id
        node_colours = [self.classifier.class_ids[self.classifier.title_2_class[target]] for target in node_titles]
        return node_colours

    def _create_walks_with_title(self, graph, node_subjects):
        rw = BiasedRandomWalk(graph)
        walks = rw.run(
            nodes=list(graph.nodes()),  # root nodes
            length=200,  # maximum length of a random walk
            n=100,  # number of random walks per root node
            p=10.0,  # Defines probability, 1/p, of returning to source node
            q=2.0,  # Defines probability, 1/q, for moving away from source node
        )
        return [[node_subjects[id_num][0] for id_num in walk] for walk in walks]

    def _create_walks_with_title_from_subgraphs(self, graph, node_subjects):

        # TODO: reduce this to the central Nodes of the individual graphs?
        root_nodes = list(graph.nodes())
        sg = SampledBreadthFirstWalk(graph)

        walks = sg.run(nodes=root_nodes,  # root nodes
                       n_size=[7, 5, 3, 2, 1],  # number of neighbouring nodes to expand at each depth
                       n=10  # number of walks per node id
                       )
        return [[node_subjects[id_num][0] for id_num in walk] for walk in walks]

    def execute(self):
        # load graph from db
        graph, node_subjects = self._load_all_graphs()
        self.logger.info("Graph loaded with nodes: {}, node_subjects contains: {} titles".format(
            len(list(graph.nodes())), len(node_subjects))
        )
        # create embedding vectors with random walks
        node_embeddings = self.create_embeddings(graph, node_subjects)
        # reload the graph with the embedding vectors
        graph, node_subjects = self._load_all_graphs(node_embeddings)

        # need to lose the list entry
        node_subjects = Series({k: v[0] for k, v in node_subjects.items()})

        self.logger.info("Graph Ready for ML: %s" % graph.check_graph_for_ml())

        # generate training data out of walks in the graph
        generator, train_gen = self._create_training_data(graph)

        # generate Model
        model, x_inp, x_out = self._create_GraphSAGE_model(generator)

        # start GraphSAGE Training
        history = model.fit(
            train_gen,
            epochs=5,
            verbose=1,
            use_multiprocessing=False,
            workers=8,
            shuffle=True,
        )

        node_embeddings, node_ids, node_subject = self._build_NodePredictor(
            graph, node_embeddings, node_subjects, x_inp, x_out)

        self._plot_graphSAGE_nodes(node_embeddings, node_ids, node_subject)

        # build a supervised predictor for downstream

    def _build_NodePredictor(self, graph, node_embeddings, node_subjects, x_inp, x_out):
        # build model on one half for prediction
        x_inp_src = x_inp[0::2]
        x_out_src = x_out[0]
        embedding_model = keras.Model(inputs=x_inp_src, outputs=x_out_src)
        node_ids = node_subjects.index
        node_gen = GraphSAGENodeGenerator(graph, GraphSAGEConfig.BATCH_SIZE, GraphSAGEConfig.NUM_SAMPLES).flow(node_ids)
        node_embeddings = embedding_model.predict(node_gen, workers=4, verbose=1)

        # prepare for plotting
        # retrieve a series of ids and the corresponding class id
        node_subject = Series({
            k: self.classifier.class_ids[
                self.classifier.title_2_class[v]
            ] for k, v in node_subjects.items()
        })
        return node_embeddings, node_ids, node_subject

    def _plot_graphSAGE_nodes(self, emb, node_ids, node_subject):
        transform = TSNE

        trans = transform(n_components=2)
        emb_transformed = pd.DataFrame(trans.fit_transform(emb), index=node_ids)
        emb_transformed["label"] = node_subject

        self._plot_embedding_scatter(
            data=emb_transformed.drop(columns=['label']),
            c=emb_transformed["label"].astype("category"),
            alpha=0.7,
            legend_alpha=0.5,
            legend_loc="lower left",
            title="2D visualization of GraphSAGE embeddings using {}".format(transform.__name__),
            activate_title=False
        )

    def _create_GraphSAGE_model(self, generator):
        graphsage = GraphSAGE(
            layer_sizes=[50, 50],
            generator=generator,
            bias=True,
            dropout=0.2,
            normalize="l2",
            activations=['gelu', 'gelu'],
            kernel_initializer="he_normal",
        )
        # Build the model and expose input and output sockets of graphsage, for node pair inputs:
        x_inp, x_out = graphsage.in_out_tensors()
        prediction = link_classification(
            output_dim=1,
            output_act="gelu",
            edge_embedding_method="ip"
        )(x_out)

        # build Model and compile
        model = keras.Model(inputs=x_inp, outputs=prediction)
        model.compile(
            optimizer=keras.optimizers.Adam(learning_rate=1e-2, decay=1e-4),
            loss=keras.losses.binary_crossentropy,
            metrics=[keras.metrics.binary_accuracy, ]
        )
        return model, x_inp, x_out

    def _create_training_data(self, graph):
        # sampler
        self.logger.info("Creating Samples out of Walks")
        # TODO: use a more sophisticated walker here
        samples = UnsupervisedSampler(
            graph,  # stellargraph with features
            nodes=list(graph.nodes()),  # If not provided, all nodes in the graph are used.
            length=GraphSAGEConfig.LENGTH_OF_WALK,
            # Length of the walks for the default Uniform Random Walker. Length must be at least 2
            number_of_walks=GraphSAGEConfig.WALKS,
            # Number of walks from each root node for the default UniformRandomWalk walker.
            # walker(RandomWalk, optional) – A RandomWalk object to use instead of the default UniformRandomWalk walker.
        )
        self.logger.info("Created walks in samples.")
        # data generator
        generator = GraphSAGELinkGenerator(
            graph,
            batch_size=GraphSAGEConfig.BATCH_SIZE,
            num_samples=GraphSAGEConfig.NUM_SAMPLES,
        )
        train_gen = generator.flow(samples)
        self.logger.info("Generated {} training data".format(train_gen.data_size))
        return generator, train_gen

    def _load_all_graphs(self, node_embeddings: Optional[Dict[int, np.ndarray]] = None):
        with Neo4JLocalConnector(self.uri) as driver:
            return driver.retrieve_all_graph(node_embeddings)


if __name__ == "__main__":
    UnsupervisedGraphSAGE().execute()

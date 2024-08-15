import stellargraph as sg
from stellargraph.mapper import CorruptedGenerator, FullBatchNodeGenerator
from stellargraph.layer import GCN, DeepGraphInfomax

import tensorflow as tf
from tensorflow.keras import Model, optimizers, callbacks
from stellargraph import datasets
from IPython.display import display, HTML


def execute_GraphInfomax():
    """
    https://stellargraph.readthedocs.io/en/v1.2.1/demos/node-classification/gcn-deep-graph-infomax-fine-tuning-node-classification.html
    :return:
    """
    G, node_classes = loadDataset()

    fullbatch_generator = FullBatchNodeGenerator(G)

    corrupted_generator = CorruptedGenerator(fullbatch_generator)
    gen = corrupted_generator.flow(G.nodes())

    def make_gcn_model():
        # function because we want to create a second one with the same parameters later
        return GCN(
            layer_sizes=[16, 16],
            activations=["relu", "relu"],
            generator=fullbatch_generator,
            dropout=0.4,
        )

    pretrained_gcn_model = make_gcn_model()

    infomax = DeepGraphInfomax(pretrained_gcn_model, corrupted_generator)
    x_in, x_out = infomax.in_out_tensors()

    dgi_model = Model(inputs=x_in, outputs=x_out)
    dgi_model.compile(
        loss=tf.nn.sigmoid_cross_entropy_with_logits, optimizer=optimizers.Adam(learning_rate=1e-3)
    )

    epochs = 500

    dgi_es = callbacks.EarlyStopping(monitor="loss", patience=50, restore_best_weights=True)
    dgi_history = dgi_model.fit(gen, epochs=epochs, verbose=0, callbacks=[dgi_es])

    sg.utils.plot_history(dgi_history)

def loadDataset():
    dataset = datasets.Cora()
    display(HTML(dataset.description))
    G, node_subjects = dataset.load()
    return G, node_subjects

if __name__ == '__main__':
    execute_GraphInfomax()
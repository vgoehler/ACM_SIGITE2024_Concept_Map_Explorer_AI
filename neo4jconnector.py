import logging
from typing import Tuple, Dict, List, Any, Optional

import numpy as np
import pandas
import pandas as pd
from neo4j import GraphDatabase
from neo4j.graph import Graph, Relationship, Node
from pandas import DataFrame
from stellargraph import StellarDiGraph
from colorLogger import configure_logging


class Neo4JLocalConnector:

    def __init__(self, uri, user=None, password=None):
        self.driver = GraphDatabase.driver(uri, auth=(user, password))

        configure_logging(logging.INFO)
        self.logger = logging.getLogger(str(type(self)))

    def close(self):
        self.driver.close()

    def retrieve_graph_of_cluster_nodes(self, node_ids):
        # Needs to be connected
        with self.driver.session() as session:
            result =session.execute_read(self._get_cluster_nodes, node_ids)

        return result

    def retrieve_all_graph(
            self, features: Optional[Dict[int, np.ndarray]] = None
    ) -> Tuple[StellarDiGraph, pandas.Series]:
        with self.driver.session() as session:
            neo4j_graph = session.execute_read(self._retrieve_all_nodes)
            stellar_graph = self._create_stellargraph_from_neo4j_graph(neo4j_graph, features)
            labels = self._create_label_series(neo4j_graph)
        assert len(stellar_graph.nodes()) == len(labels), (
            "length of stellargraph ({}) does not match labels ({})".format(
                len(stellar_graph.nodes()), len(labels))
        )
        return stellar_graph, labels

    def _create_stellargraph_from_neo4j_graph(
            self, input_graph: Graph, features: Optional[Dict[int, np.ndarray]] = None
    ) -> StellarDiGraph:
        edges = self._edges_to_df(input_graph)
        nodes = self._nodes_to_df(input_graph, features)
        return StellarDiGraph(
            nodes=nodes, edges=edges, edge_type_column='type', edge_type_default='not set', node_type_default='concept'
        )

    def _nodes_to_df(
            self, input_graph: Graph, features: Optional[Dict[int, np.ndarray]] = None
    ) -> DataFrame:
        self.logger.info("nodes count: {} | features length: {}".format(
            len(input_graph.nodes),
            len(features) if features is not None else 0))
        index = [node.id for node in input_graph.nodes]

        if features is None:
            nodes = pd.DataFrame(index=index)
        else:
            nodes = pd.DataFrame(
                [features[idx] for idx in index],
                index=index
            )

        return nodes

    @staticmethod
    def _edges_to_df(input_graph: Graph) -> DataFrame:
        edges_dict = {
            'source': [],
            'target': [],
            'type': []
        }

        edge: Relationship
        for edge in input_graph.relationships:
            edges_dict['source'].append(edge.start_node.id)
            edges_dict['target'].append(edge.end_node.id)
            edges_dict['type'].append(edge.type)

        # it needs weights! TODO, weight them down according to elicitation?
        edges_dict['weight'] = [1] * len(edges_dict['source'])
        edges = pd.DataFrame(edges_dict)
        return edges

    @staticmethod
    def _create_label_series(db_graph: Graph) -> pandas.Series:
        node_dict = {node.id: [node['title'], node['source']] for node in db_graph.nodes}
        return pandas.Series(node_dict, index=node_dict.keys())

    @staticmethod
    def _retrieve_all_nodes(tx):
        result = tx.run("MATCH (n)-[r]->(m) "
                        "RETURN n,r,m ")
        return result.graph()

    @staticmethod
    def _retrieve_nodes_from_source(tx, source_name):
        result = tx.run("MATCH(n)-[r]->(m) "
                        "WHERE n.file_name = $source_name "
                        "RETURN n,r,m ", source_name=source_name)
        return result.graph()

    @staticmethod
    def _get_all_file_names(tx):
        result = tx.run("MATCH(n:ai) "
                        "WITH COLLECT(DISTINCT n.file_name) as sources "
                        "RETURN sources")
        return result.single(True)

    @staticmethod
    def _get_cluster_nodes(tx, node_ids):
        query = """
        MATCH (n)
        WHERE n.id IN $node_ids
        RETURN n.id AS node_id
        """
        result = tx.run(query, node_ids=node_ids)
        return result.single(True)


    def __enter__(self):
        return self

    def __exit__(self, *args):
        self.close()

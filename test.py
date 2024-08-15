import pandas as pd
from stellargraph import StellarGraph

def runAll():
    # Create a DataFrame for nodes with their names
    node_data = pd.DataFrame({
        "name": ["Alice", "Bob", "Charlie"],
        "feature": [1,2,3],
    }, index=["A", "B", "C"])  # Node IDs are A, B, C

    # Create a DataFrame for edges
    edge_data = pd.DataFrame({
        "source": ["A", "B", "C"],
        "target": ["B", "C", "A"],
    })

    # Create the StellarGraph object
    graph = StellarGraph(nodes=node_data, edges=edge_data, node_features="feature")

    # Print the graph to verify
    print(graph.info())

if __name__ == "__main__":
    runAll()
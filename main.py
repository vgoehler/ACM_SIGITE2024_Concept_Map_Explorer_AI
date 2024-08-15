import numpy as np
import pandas as pd

import semisupervised_DeepGraphInfomax

# additional weight as a entry! any additional entries are getting put as features on the edges
# also type for the type of the edges possible
edges = pd.DataFrame(
    {"source": ["a", "b", "c", "d", "a"], "target": ["b", "c", "d", "a", "c"]}
)
# nodes get infered by the edges DataFrame
# nodes = IndexedArray(index=["a", "b", "c", "d"])

# feature array for graph with 2 features
feature_array = np.array([[-1, 0.4], [2, 0.1], [-3, 0.9], [4, 0]])
# nodes = IndexedArray(index=["a", "b", "c", "d"])

# equivalent to

nodes = pd.DataFrame(
    {"x": [-1,2,-3,4], "y": [0.4,0.1,0.9,0]}, index=["a", "b", "c", "d"]
)

# also nodes can be a dictionary, if we have different types, also for edges

# Gs = StellarDiGraph(nodes=nodes, edges=edges)

#unsupervised_GraphSAGE.execute_GRAPHSAGE_Example()

semisupervised_DeepGraphInfomax.execute_GraphInfomax()

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    pass



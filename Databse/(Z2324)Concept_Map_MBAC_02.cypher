WITH '(Z2324)Concept_Map_MBAC_02.cypher' AS file_name

CREATE (AI:ai {title:'Artificial Intelligence', file_name: file_name})
CREATE (Agents:point {title:'Intelligent Agents', file_name: file_name})
CREATE (Systems:point {title:'Intelligent Systems', file_name: file_name})
CREATE (ML:point {title:'Machine Learning', file_name: file_name})
CREATE (Supervised:point {title:'Supervised Learning', file_name: file_name})
CREATE (Classification:point {title:'Classification', file_name: file_name})
CREATE (DecisionTree:point {title:'Decision Tree', file_name: file_name})
CREATE (kNN:point {title:'kNN (k nearest neighbors)', file_name: file_name})
CREATE (Unsupervised:point {title:'Unsupervised Learning', file_name: file_name})
CREATE (Clustering:point {title:'Clustering', file_name: file_name})
CREATE (DecisionTree2:point {title:'Decision Tree', file_name: file_name})
CREATE (Logic:point {title:'Programming with Logic', file_name: file_name})
CREATE (Prolog:point {title:'Prolog Excursion', file_name: file_name})
CREATE (Applications:point {title:'Applications', file_name: file_name})
CREATE (Robotics:point {title:'Robotics', file_name: file_name})
CREATE (Factories:point {title:'Automated Factories', file_name: file_name})
CREATE (Driving:point {title:'Autonomous Driving', file_name: file_name})
CREATE (Drones:point {title:'Drones', file_name: file_name})
CREATE (Imaging:point {title:'Imaging Procedures in Medicine', file_name: file_name})
CREATE (ProblemSolving:point {title:'Problem Solving', file_name: file_name})
CREATE (Goal:point {title:'their goal is', file_name: file_name})

CREATE
    (AI)-[:consists_of]->(Agents),
    (Agents)-[:leads_to]->(Systems),
    (AI)-[:consists_of]->(ML),
    (ML)-[:includes]->(Supervised),
    (Supervised)-[:includes]->(Classification),
    (Classification)-[:includes]->(DecisionTree),
    (Classification)-[:includes]->(kNN),
    (ML)-[:includes]->(Unsupervised),
    (Unsupervised)-[:includes]->(Clustering),
    (ML)-[:includes]->(DecisionTree2),
    (AI)-[:consists_of]->(Logic),
    (Logic)-[:includes]->(Prolog),
    (AI)-[:includes]->(Applications),
    (Applications)-[:includes]->(Robotics),
    (Applications)-[:includes]->(Factories),
    (Factories)-[:includes]->(Driving),
    (Factories)-[:includes]->(Drones),
    (Applications)-[:includes]->(Imaging),
    (AI)-[:goal_is]->(ProblemSolving),
    (ProblemSolving)-[:goal_is]->(Goal)

WITH '(D2324)Concept_Map_MBAC_01.cypher' AS file_name

CREATE (AI:ai {title:'Artificial Intelligence', file_name: file_name})
CREATE (Intelligence:point {title:'Intelligence', file_name: file_name})
CREATE (Evolution:point {title:'Evolution', file_name: file_name})
CREATE (Programming:point {title:'Programming', file_name: file_name})
CREATE (Applications:point {title:'Applications', file_name: file_name})
CREATE (Types:point {title:'AI Types', file_name: file_name})
CREATE (Algorithms:point {title:'Algorithms', file_name: file_name})
CREATE (Optimization:point {title:'Optimization', file_name: file_name})
CREATE (Standard:point {title:'Standard', file_name: file_name})
CREATE (Unsupervised:point {title:'Unsupervised', file_name: file_name})
CREATE (Neural:point {title:'Neural Networks', file_name: file_name})
CREATE (Humans:point {title:'Humans', file_name: file_name})
CREATE (Swarm:point {title:'Swarm Intelligence', file_name: file_name})
CREATE (DeepLearning:point {title:'Deep Learning', file_name: file_name})
CREATE (Generic:point {title:'Generic', file_name: file_name})
CREATE (Independent:point {title:'Human-like/Independent', file_name: file_name})
CREATE (Cluster:point {title:'Cluster', file_name: file_name})
CREATE (ML:point {title:'Machine Learning', file_name: file_name})
CREATE (NLP:point {title:'Natural Language Processing', file_name: file_name})
CREATE (Robotics:point {title:'Robotics', file_name: file_name})
CREATE (Analytics:point {title:'Analytics', file_name: file_name})
CREATE (Agents:point {title:'Intelligent Agents', file_name: file_name})
CREATE (Virtual:point {title:'Virtual Intelligence', file_name: file_name})
CREATE (Diagnosis:point {title:'Diagnosis', file_name: file_name})

CREATE
    (AI)-[:consists_of]->(Intelligence),
    (AI)-[:consists_of]->(Evolution),
    (AI)-[:consists_of]->(Programming),
    (AI)-[:consists_of]->(Applications),
    (AI)-[:consists_of]->(Types),
    (AI)-[:consists_of]->(Algorithms),

    (Algorithms)-[:consists_of]->(Optimization),
    (Algorithms)-[:consists_of]->(Standard),
    (Algorithms)-[:consists_of]->(Unsupervised),
    
    (Intelligence)-[:consists_of]->(Neural),
    (Intelligence)-[:consists_of]->(Humans),
    (Intelligence)-[:consists_of]->(Swarm),
    (Intelligence)-[:consists_of]->(DeepLearning),

    (Types)-[:consists_of]->(Generic),
    (Types)-[:consists_of]->(Independent),
    (Programming)-[:consists_of]->(Cluster),

    (Applications)-[:consists_of]->(ML),
    (Applications)-[:consists_of]->(NLP),
    (Applications)-[:consists_of]->(Robotics),
    (Applications)-[:consists_of]->(Analytics),
    (Applications)-[:consists_of]->(Agents),
    (Applications)-[:consists_of]->(Virtual),
    (Applications)-[:consists_of]->(Diagnosis)


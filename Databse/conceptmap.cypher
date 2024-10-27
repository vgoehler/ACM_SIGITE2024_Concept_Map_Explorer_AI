WITH 'conceptmap.cypher' AS file_name

CREATE (AI:ai {title:'Artificial Intelligence', file_name: file_name})
CREATE (Ethics:point {title:'Ethics', file_name: file_name})
CREATE (ArtificialConscience:point {title:'Artificial Conscience', file_name: file_name})
CREATE (IndependentLearning:point {title:'Independent Learning', file_name: file_name})
CREATE (Performance:point {title:'Performance', file_name: file_name})
CREATE (Rationale:point {title:'Rationale', file_name: file_name})
CREATE (Emotions:point {title:'Emotions', file_name: file_name})
CREATE (ML:point {title:'Machine Learning', file_name: file_name})
CREATE (Data:point {title:'Data', file_name: file_name})
CREATE (Rules:point {title:'Rules', file_name: file_name})
CREATE (FehlerFunction:point {title:'Fehler Function', file_name: file_name})

CREATE
    (AI)-[:raises_question]->(Ethics),
    (AI)-[:as_is]->(ArtificialConscience),
    (AI)-[:as_is]->(IndependentLearning),
    (Ethics)-[:discuss_applicability]->(ArtificialConscience),
    (IndependentLearning)-[:similar_to]->(ArtificialConscience),
    (ArtificialConscience)-[:requirements]->(Rationale),
    (ArtificialConscience)-[:requirements]->(Emotions),
    (ArtificialConscience)-[:requirements]->(Performance),
    (Rationale)-[:contrast]->(Emotions),
    (Emotions)-[:contrast]->(Rationale),
    (IndependentLearning)-[:realization]->(ML),
    (ML)-[:needs]->(Data),
    (ML)-[:needs]->(Rules),
    (Rules)-[:realization]->(FehlerFunction)

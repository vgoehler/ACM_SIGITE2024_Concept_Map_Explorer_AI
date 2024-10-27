WITH '(D2324)Concept_Map_MM_03.cypher' AS file_name

CREATE (AI:ai {title:'AI', file_name: file_name})
CREATE (Human:point {title:'Human', file_name: file_name})
CREATE (Results:point {title:'Results/Behaviour', file_name: file_name})
CREATE (Algorithms:point {title:'Algorithms', file_name: file_name})
CREATE (ML:point {title:'Machine Learning', file_name: file_name})
CREATE (Objective:point {title:'Objective', file_name: file_name})
CREATE (Data:point {title:'Data', file_name: file_name})
CREATE (Danger:point {title:'Danger', file_name: file_name})
CREATE (Cluster:point {title:'Cluster', file_name: file_name})
CREATE (Regression:point {title:'Regression', file_name: file_name})
CREATE (NN:point {title:'Neural Network', file_name: file_name})
CREATE (LAgents:point {title:'Learning Agents', file_name: file_name})
CREATE (Searching:point {title:'Searching', file_name: file_name})
CREATE (Rationality:point {title:'Rationality', file_name: file_name})
CREATE (LogicInfering:point {title:'Logic Infering', file_name: file_name})
CREATE (PerformanceAppraisal:point {title:'Performance appraisal', file_name: file_name})
CREATE (Environment:point {title:'Environment', file_name: file_name})
CREATE (Actuators:point {title:'Actuators', file_name: file_name})
CREATE (Sensors:point {title:'Sensors', file_name: file_name})
CREATE (Action:point {title:'Action', file_name: file_name})
CREATE (Communicate:point {title:'Communicate', file_name: file_name})
CREATE (KnowledgeBase:point {title:'Knowledge base', file_name: file_name})
CREATE (Communication:point {title:'Communication', file_name: file_name})
CREATE (Language:point {title:'Language', file_name: file_name})
CREATE (Internal:point {title:'Internal', file_name: file_name})
CREATE (External:point {title:'External', file_name: file_name})
CREATE (Consciousness:point {title:'Consciousness', file_name: file_name})
CREATE (WeakAI:point {title:'Weak AI', file_name: file_name})
CREATE (StrongAI:point {title:'Strong AI', file_name: file_name})

CREATE
    (Human)-[:as_starting_point]->(AI),
    (AI)-[:should_provide]->(Results),
    (AI)-[:is_maybe_viewed_as]->(Danger),
    (AI)-[:changes]->(Objective),
    (ML)-[:subarea_of]->(AI),
    (ML)-[:consists_of]->(Cluster),
    (ML)-[:consists_of]->(Regression),
    (ML)-[:consists_of]->(NN),
    (Data)-[:needed_for]->(Algorithms),
    (Algorithms)-[:special_case]->(AI),
    (AI)-[:question_on]->(Consciousness),
    (Consciousness)-[:consists_of]->(WeakAI),
    (Consciousness)-[:consists_of]->(StrongAI),

    (AI)-[:depiction_model]->(LAgents),
    (LAgents)-[:consists_of]->(LogicInfering),
    (LAgents)-[:consists_of]->(Rationality),
    (LAgents)-[:consists_of]->(Searching),
    
    (LAgents)-[:is_needed_for_learning]->(PerformanceAppraisal),
    (LAgents)-[:consists_of]->(Actuators),
    (LAgents)-[:consists_of]->(Sensors),
    (PerformanceAppraisal)-[:influenced]->(Actuators),
    (Environment)-[:perception]->(Sensors),
    (Actuators)-[:provides]->(Action),
    (Action)-[:in_the_environment]->(Environment),
    (Action)-[:is_assesed_by_certain_criteria]->(PerformanceAppraisal),

    (Communication)-[:with]->(Environment),
    (Communication)-[:between]->(LAgents),
    (Communication)-[:needs]->(KnowledgeBase),
    (KnowledgeBase)-[:owns]->(Communicate),
    (Communicate)-[:consists_of]->(LAgents),

    (Language)-[:consists_of]->(Internal),
    (Language)-[:consists_of]->(External),
    (Language)-[:to]->(Communication)


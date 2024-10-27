WITH '(D2324)Concept_Map_ROB_02.cypher' AS file_name

CREATE (AI:ai {title:'AI', file_name: file_name})
CREATE (MachineLearning:point {title:'Machine Learning', file_name: file_name})
CREATE (ImageGeneration:point {title:'Image Generation', file_name: file_name})
CREATE (ImageRecognition:point {title:'Image Recognition', file_name: file_name})
CREATE (LLM:point {title:'LLM', file_name: file_name})
CREATE (Bard:point {title:'Bard', file_name: file_name})
CREATE (ChatGPT:point {title:'ChatGPT', file_name: file_name})
CREATE (Hallucination:point {title:'Hallucination', file_name: file_name})
CREATE (NeedsToBeCheckedByHumans:point {title:'Needs to be Checked by humans', file_name: file_name})
CREATE (Data:point {title:'Data', file_name: file_name})
CREATE (Training:point {title:'Training', file_name: file_name})
CREATE (QualityDependsOnData:point {title:'Quality depends on data', file_name: file_name})
CREATE (Algorithms:point {title:'Algorithms', file_name: file_name})
CREATE (ArtificialNeuron:point {title:'Artificial Neuron', file_name: file_name})
CREATE (TensorFlow:point {title:'Tensor Flow', file_name: file_name})
CREATE (BiologicallyInspired:point {title:'Biologically Inspired', file_name: file_name})
CREATE (Layers:point {title:'Layers', file_name: file_name})
CREATE (GeneticAlgorithms:point {title:'Genetic Algorithms', file_name: file_name})
CREATE (BasedOnEvolutionaryTheoryNotSafe:point {title:'Based on Evolutionary theory not safe', file_name: file_name})
CREATE (AIThroughLogic:point {title:'AI through logic', file_name: file_name})
CREATE (Prolog:point {title:'Prolog', file_name: file_name})
CREATE (OnlyForTeaching:point {title:'Only for teaching', file_name: file_name})
CREATE (Fact:point {title:'Fact', file_name: file_name})
CREATE (Rules:point {title:'Rules', file_name: file_name})
CREATE (Question:point {title:'Question', file_name: file_name})
CREATE (DecisionsByRules:point {title:'Decisions by rules', file_name: file_name})
CREATE (LearningAgents:point {title:'Learning agents', file_name: file_name})
CREATE (DifferentStrategiesDependentOnWorld:point {title:'Different strategies dependent on world', file_name: file_name})
CREATE (SomeAgentsCanChangeTheirRules:point {title:'Some agents can change their rules', file_name: file_name})
CREATE (NeedsExpertKnowledge:point {title:'Needs expert knowledge', file_name: file_name})
CREATE (DifferentWorlds:point {title:'Different worlds', file_name: file_name})
CREATE (AllKnownKnowledgeOfTheWorld:point {title:'All known knowledge of the world', file_name: file_name})
CREATE (NotCompleteWorldKnowledge:point {title:'Not complete world knowledge', file_name: file_name})
CREATE (More:point {title:'More', file_name: file_name})

CREATE
    (AI)-[:consists_of]->(MachineLearning),
    (AI)-[:consists_of]->(GeneticAlgorithms),
    (AI)-[:consists_of]->(DecisionsByRules),
    (AI)-[:consists_of]->(AIThroughLogic),

    (AIThroughLogic)-[:consists_of]->(Prolog),
    (Prolog)-[:consists_of]->(OnlyForTeaching),
    (Prolog)-[:consists_of]->(Fact),
    (Prolog)-[:consists_of]->(Rules),
    (Prolog)-[:consists_of]->(Question),

    (GeneticAlgorithms)-[:consists_of]->(BasedOnEvolutionaryTheoryNotSafe),

    (DecisionsByRules)-[:consists_of]->(LearningAgents),
    (DecisionsByRules)-[:consists_of]->(DifferentWorlds),
    (DecisionsByRules)-[:consists_of]->(NeedsExpertKnowledge),

    (LearningAgents)-[:consists_of]->(DifferentStrategiesDependentOnWorld),
    (DifferentStrategiesDependentOnWorld)-[:consists_of]->(SomeAgentsCanChangeTheirRules),

    (DifferentWorlds)-[:consists_of]->(More),
    (DifferentWorlds)-[:consists_of]->(AllKnownKnowledgeOfTheWorld),
    (DifferentWorlds)-[:consists_of]->(NotCompleteWorldKnowledge),

    (MachineLearning)-[:consists_of]->(ImageGeneration),
    (MachineLearning)-[:consists_of]->(ImageRecognition),
    (MachineLearning)-[:consists_of]->(Data),
    (MachineLearning)-[:consists_of]->(Training),
    (MachineLearning)-[:basis_for]->(LLM),
    (Data)-[:used_for]->(Training),

    (LLM)-[:example]->(ChatGPT),
    (LLM)-[:example]->(Bard),
    (ChatGPT)-[:consists_of]->(Hallucination),
    (Hallucination)-[:consists_of]->(NeedsToBeCheckedByHumans),

    (Training)-[:consists_of]->(QualityDependsOnData),
    (Training)-[:generates]->(Algorithms),

    (Algorithms)-[:consists_of]->(ArtificialNeuron),
    (ArtificialNeuron)-[:consists_of]->(TensorFlow),
    (ArtificialNeuron)-[:consists_of]->(BiologicallyInspired),
    (BiologicallyInspired)-[:consists_of]->(Layers)

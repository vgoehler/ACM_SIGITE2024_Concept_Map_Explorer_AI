WITH '(D2324)Concept_Map_AI_02.cypher' AS file_name

CREATE (AI:ai {title:'AI', file_name: file_name})
CREATE (DifferentTypes:point {title:'Different Types (Agents)', file_name: file_name})
CREATE (MathematicBasics:point {title:'Mathematic Basics', file_name: file_name})
CREATE (StatisticalInfering:point {title:'Statistical Infering', file_name: file_name})
CREATE (UncertainInfering:point {title:'Uncertain Infering', file_name: file_name})
CREATE (LogicInfering:point {title:'Logic Infering', file_name: file_name})
CREATE (TemporalInfering:point {title:'Temporal Infering', file_name: file_name})
CREATE (InflactionaryTermUsage:point {title:'Inflactionary Term Usage', file_name: file_name})
CREATE (QuestionOfDefinition:point {title:'Question of definition', file_name: file_name})
CREATE (UnclearBorders:point {title:'Unclear Borders', file_name: file_name})
CREATE (BasicsOfLaw:point {title:'Basics of law', file_name: file_name})
CREATE (CallForAction:point {title:'Call for Action', file_name: file_name})
CREATE (Consciousness:point {title:'Consciousness', file_name: file_name})
CREATE (HumanlikeIntelligence:point {title:'Humanlike Intelligence', file_name: file_name})
CREATE (ConvolutionalNetworks:point {title:'Convolutional Networks', file_name: file_name})
CREATE (DeepLearning:point {title:'Deep Learning', file_name: file_name})
CREATE (NeuralNets:point {title:'Neural Nets', file_name: file_name})
CREATE (HumanAnalogous:point {title:'Human Analogous', file_name: file_name})
CREATE (LLM:point {title:'LLM', file_name: file_name})
CREATE (ChatGPT:point {title:'Chat GPT', file_name: file_name})
CREATE (ChangeOfWorkEnvironment:point {title:'Change of work environment', file_name: file_name})
CREATE (GenerativeImageAI:point {title:'Generative Image AI', file_name: file_name})
CREATE (MidJourney:point {title:'Mid Journey', file_name: file_name})
CREATE (AutonomousDriving:point {title:'Autonomous Driving', file_name: file_name})
CREATE (Games:point {title:'Games', file_name: file_name})
CREATE (HumanRights:point {title:'Human Rights', file_name: file_name})
CREATE (Companies:point {title:'Companies: Google Microsoft OpenAI Meta', file_name: file_name})
CREATE (Historic:point {title:'Historic', file_name: file_name})
CREATE (ManyBreakthroughs:point {title:'Currently (seemingly) many breakthroughs + a lot of money', file_name: file_name})
CREATE (VeryOldIdea:point {title:'Very old idea', file_name: file_name})
CREATE (DevelopmentNotToStop:point {title:'Development is not to stop', file_name: file_name})
CREATE (MultipleAIWinters:point {title:'Multiple AI Winters', file_name: file_name})
CREATE (Applications:point {title:'Applications', file_name: file_name})
CREATE (Medicine:point {title:'Medicine', file_name: file_name})
CREATE (Symptoms:point {title:'Symptoms', file_name: file_name})
CREATE (Diagnosis:point {title:'Diagnosis', file_name: file_name})
CREATE (LogicProgrammingLanguages:point {title:'Logic Programming Languages', file_name: file_name})
CREATE (Prolog:point {title:'Prolog', file_name: file_name})
CREATE (InBrowser:point {title:'In browser', file_name: file_name})
CREATE (ChatGPTDuplicate:point {title:'Chat GPT', file_name: file_name}) // Duplicate node
CREATE (GamesDuplicate:point {title:'Games', file_name: file_name}) // Duplicate node
CREATE (DataAnalysis:point {title:'Data Analysis', file_name: file_name})
CREATE (ObjectDetection:point {title:'Object Detection', file_name: file_name})
CREATE (Yolo:point {title:'Yolo', file_name: file_name})
CREATE (PyTorch:point {title:'PyTorch', file_name: file_name})
CREATE (Public:point {title:'Public', file_name: file_name})
CREATE (Fear:point {title:'Fear "Red Button"', file_name: file_name})
CREATE (WorldwideMoratorium:point {title:'Worldwide Moratorium', file_name: file_name})
CREATE (ML:point {title:'Machine Learning', file_name: file_name})
CREATE (Perceptron:point {title:'Perceptron', file_name: file_name})

CREATE
    (AI)-[:as_is]->(DifferentTypes),
    (AI)-[:as_is]->(QuestionOfDefinition),
    (AI)-[:as_is]->(Public),
    (AI)-[:as_is]->(Historic),
    (AI)-[:as_is]->(Applications),

    (DifferentTypes)-[:consists_of]->(NeuralNets),
    (DifferentTypes)-[:consists_of]->(Consciousness),
    (DifferentTypes)-[:consists_of]->(QuestionOfDefinition),
    (DifferentTypes)-[:consists_of]->(MathematicBasics),

    (Consciousness)-[:consists_of]->(HumanlikeIntelligence),

    (NeuralNets)-[:consists_of]->(Perceptron),
    (NeuralNets)-[:consists_of]->(ML),
    (NeuralNets)-[:consists_of]->(HumanAnalogous),
    (NeuralNets)-[:consists_of]->(DeepLearning),
    (DeepLearning)-[:consists_of]->(ConvolutionalNetworks),

    (MathematicBasics)-[:consists_of]->(StatisticalInfering),
    (MathematicBasics)-[:consists_of]->(UncertainInfering),
    (MathematicBasics)-[:consists_of]->(LogicInfering),
    (MathematicBasics)-[:consists_of]->(TemporalInfering),

    (QuestionOfDefinition)-[:consists_of]->(InflactionaryTermUsage),
    (QuestionOfDefinition)-[:consists_of]->(UnclearBorders),
    (QuestionOfDefinition)-[:consists_of]->(BasicsOfLaw),
    (QuestionOfDefinition)-[:consists_of]->(CallForAction),

    (Public)-[:consists_of]->(Fear),
    (Fear)-[:consists_of]->(WorldwideMoratorium),
    (Public)-[:consists_of]->(LLM),
    (LLM)-[:consists_of]->(ChatGPT),
    (Public)-[:consists_of]->(ChangeOfWorkEnvironment),
    (Public)-[:consists_of]->(GenerativeImageAI),
    (GenerativeImageAI)-[:consists_of]->(MidJourney),
    (Public)-[:consists_of]->(AutonomousDriving),
    (Public)-[:consists_of]->(Games),
    (Public)-[:consists_of]->(Companies),
    (Public)-[:consists_of]->(HumanRights),

    (Historic)-[:consists_of]->(ManyBreakthroughs),
    (Historic)-[:consists_of]->(VeryOldIdea),
    (Historic)-[:consists_of]->(DevelopmentNotToStop),
    (Historic)-[:consists_of]->(MultipleAIWinters),

    (Applications)-[:consists_of]->(Medicine),
    (Medicine)-[:consists_of]->(Symptoms),
    (Medicine)-[:consists_of]->(Diagnosis),
    (Applications)-[:consists_of]->(LogicProgrammingLanguages),
    (LogicProgrammingLanguages)-[:consists_of]->(Prolog),
    (Applications)-[:consists_of]->(InBrowser),
    (InBrowser)-[:consists_of]->(ChatGPTDuplicate),
    (Applications)-[:consists_of]->(GamesDuplicate),
    (Applications)-[:consists_of]->(DataAnalysis),
    (Applications)-[:consists_of]->(ObjectDetection),
    (ObjectDetection)-[:consists_of]->(Yolo),
    (ObjectDetection)-[:consists_of]->(PyTorch)




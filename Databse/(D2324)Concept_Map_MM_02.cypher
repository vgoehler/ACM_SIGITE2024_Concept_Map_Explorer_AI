WITH '(D2324)Concept_Map_MM_02.cypher' AS file_name

CREATE (AI:ai {title:'AI', file_name: file_name})
CREATE (Learning:point {title:'Learning', file_name: file_name})
CREATE (Data:point {title:'Data', file_name: file_name})
CREATE (Conclusions:point {title:'Conclusions', file_name: file_name})
CREATE (Algorithms:point {title:'Algorithms', file_name: file_name})
CREATE (StochasticStatistic:point {title:'Stochastic/Statistic', file_name: file_name})
CREATE (ML:point {title:'Machine Learning', file_name: file_name})
CREATE (Regression:point {title:'Regression', file_name: file_name})
CREATE (Classification:point {title:'Classification', file_name: file_name})
CREATE (Methods:point {title:'Methods', file_name: file_name})
CREATE (NN:point {title:'Neural Networks', file_name: file_name})
CREATE (Bayes:point {title:'Bayes Algorithm', file_name: file_name})
CREATE (SVM:point {title:'Support Vector Machines', file_name: file_name})
CREATE (Importance:point {title:'Importance', file_name: file_name})
CREATE (Vision:point {title:'Vision', file_name: file_name})
CREATE (Change:point {title:'Is in change', file_name: file_name})
CREATE (Society:point {title:'Call in Society', file_name: file_name})
CREATE (Fear:point {title:'Fear', file_name: file_name})
CREATE (Assistance:point {title:'Assistance', file_name: file_name})
CREATE (AIAct:point {title:'Artificial empowered to independent act', file_name: file_name})
CREATE (Robots:point {title:'Robots', file_name: file_name})
CREATE (Programs:point {title:'Programs', file_name: file_name})
CREATE (InputProcessing:point {title:'Processing of Input data', file_name: file_name})
CREATE (Agents:point {title:'Learning Agents', file_name: file_name})
CREATE (Prediction:point {title:'Prediction', file_name: file_name})
CREATE (Sensors:point {title:'Sensors', file_name: file_name})
CREATE (Processing:point {title:'Processing', file_name: file_name})
CREATE (Applications:point {title:'Applications', file_name: file_name})
CREATE (DependsOn:point {title:'Depends on', file_name: file_name})
CREATE (Prolog:point {title:'Prolog', file_name: file_name})
CREATE (AvailableKnowledge:point {title:'Available knowledge', file_name: file_name})
CREATE (UsableKnowledge:point {title:'Usable knowledge', file_name: file_name})
CREATE (Toolkits:point {title:'Toolkits', file_name: file_name})
CREATE (MATLAB:point {title:'MATLAB', file_name: file_name})
CREATE (TensorFlow:point {title:'TensorFlow', file_name: file_name})
CREATE (PyTorch:point {title:'PyTorch', file_name: file_name})
CREATE (Keras:point {title:'Keras', file_name: file_name})
CREATE (Python:point {title:'Python', file_name: file_name})
CREATE (Input:point {title:'Input', file_name: file_name})
CREATE (Normalize:point {title:'Normalize', file_name: file_name})
CREATE (ErrorFunction:point {title:'Error function', file_name: file_name})
CREATE (QuadraticLoss:point {title:'Quadratic loss', file_name: file_name})
CREATE (D1Loss:point {title:'D-1 loss', file_name: file_name})
CREATE (LogLoss:point {title:'log loss', file_name: file_name})
CREATE (Weights:point {title:'Weights', file_name: file_name})
CREATE (Learned:point {title:'Being learned', file_name: file_name})
CREATE (MinimizeError:point {title:'Minimize error function', file_name: file_name})
CREATE (ERMLearning:point {title:'ERM-Learning', file_name: file_name})
CREATE (ActivationFunc:point {title:'Activation Function', file_name: file_name})
CREATE (Differentiable:point {title:'Differentiable', file_name: file_name})
CREATE (Tanh:point {title:'Tanh', file_name: file_name})
CREATE (Sigmoid:point {title:'Sigmoid', file_name: file_name})
CREATE (NotDiff:point {title:'Not classic differentiable', file_name: file_name})
CREATE (ReLU:point {title:'relu', file_name: file_name})
CREATE (HeavySide:point {title:'heavy side', file_name: file_name})
CREATE (Output:point {title:'Output', file_name: file_name})


CREATE
    (AI)-[:consists_of]->(Learning),
    (AI)-[:consists_of]->(Algorithms),
    (AI)-[:consists_of]->(Applications),
    (AI)-[:consists_of]->(Importance),
    
    (Learning)-[:consists_of]->(Data),
    (Data)-[:consists_of]->(Conclusions),
    (Conclusions)-[:consists_of]->(Learning),

    (Applications)-[:consists_of]->(Prolog),
    (Applications)-[:consists_of]->(DependsOn),
    (DependsOn)-[:consists_of]->(AvailableKnowledge),
    (DependsOn)-[:consists_of]->(UsableKnowledge),

    (Importance)-[:consists_of]->(Change),
    (Importance)-[:consists_of]->(Vision),
    (Importance)-[:consists_of]->(AIAct),
    (Importance)-[:consists_of]->(Society),
    (Society)-[:consists_of]->(Fear),
    (Society)-[:consists_of]->(Assistance),

    (AIAct)-[:consists_of]->(Programs),
    (Programs)-[:consists_of]->(InputProcessing),
    (AIAct)-[:consists_of]->(Robots),
    (AIAct)-[:consists_of]->(Agents),
    (Agents)-[:consists_of]->(Prediction),
    (Agents)-[:consists_of]->(Sensors),
    (Agents)-[:consists_of]->(Processing),

    (Learning)-[:consists_of]->(ML),
    (Algorithms)-[:consists_of]->(ML),

    (ML)-[:consists_of]->(StochasticStatistic),
    (ML)-[:consists_of]->(Toolkits),
    (ML)-[:consists_of]->(Regression),
    (ML)-[:consists_of]->(Classification),
    (ML)-[:consists_of]->(Methods),

    (Methods)-[:consists_of]->(Bayes),
    (Methods)-[:consists_of]->(SVM),
    (Methods)-[:consists_of]->(NN),

    (Toolkits)-[:consists_of]->(MATLAB),
    (Toolkits)-[:consists_of]->(PyTorch),
    (Toolkits)-[:consists_of]->(Keras),
    (Toolkits)-[:consists_of]->(TensorFlow),
    (TensorFlow)-[:consists_of]->(Python),
    (Keras)-[:consists_of]->(Python),

    (NN)-[:consists_of]->(Input),
    (Input)-[:consists_of]->(Normalize),
    
    (NN)-[:consists_of]->(ErrorFunction),
    (ErrorFunction)-[:consists_of]->(QuadraticLoss),
    (ErrorFunction)-[:consists_of]->(D1Loss),
    (ErrorFunction)-[:consists_of]->(LogLoss),

    (NN)-[:consists_of]->(Weights),
    (Weights)-[:consists_of]->(Learned),
    (Learned)-[:consists_of]->(ERMLearning),
    (Learned)-[:consists_of]->(MinimizeError),

    (NN)-[:consists_of]->(Output),

    (NN)-[:consists_of]->(ActivationFunc),
    (ActivationFunc)-[:consists_of]->(Differentiable),
    (Differentiable)-[:consists_of]->(Tanh),
    (Differentiable)-[:consists_of]->(Sigmoid),
    (ActivationFunc)-[:consists_of]->(NotDiff),
    (NotDiff)-[:consists_of]->(HeavySide),
    (NotDiff)-[:consists_of]->(ReLU)


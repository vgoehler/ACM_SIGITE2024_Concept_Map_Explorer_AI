WITH '(D2324)Concept_Map_AI_01.cypher' AS file_name

CREATE (AI:ai {title:'Artificial Intelligence', file_name: file_name})
CREATE (Algorithms:point {title:'Other "Smart" Algorithms', file_name: file_name})
CREATE (Interpolation:point {title:'Interpolation', file_name: file_name})
CREATE (ML:point {title:'Machine Learning', file_name: file_name})
CREATE (Regression:point {title:'Regression', file_name: file_name})
CREATE (Overfitting:point {title:'Overfitting', file_name: file_name})
CREATE (Data:point {title:'Data', file_name: file_name})
CREATE (TrainingData:point {title:'Training Data', file_name: file_name})
CREATE (EvaluationData:point {title:'Evaluation Data', file_name: file_name})
CREATE (Text:point {title:'Text', file_name: file_name})
CREATE (Audio:point {title:'Audio', file_name: file_name})
CREATE (Image:point {title:'Image', file_name: file_name})
CREATE (MeasuringData:point {title:'Measuring Data', file_name: file_name})
CREATE (OtherValues:point {title:'Other Values', file_name: file_name})
CREATE (Model:point {title:'Model', file_name: file_name})
CREATE (NeuralNetwork:point {title:'Neural Network', file_name: file_name})
CREATE (Layer:point {title:'Layer', file_name: file_name})
CREATE (Error:point {title:'Error', file_name: file_name})
CREATE (Neuron:point {title:'Neuron', file_name: file_name})
CREATE (Activation:point {title:'Activation', file_name: file_name})
CREATE (Step:point {title:'Step', file_name: file_name})
CREATE (Sigmoid:point {title:'Sigmoid', file_name: file_name})
CREATE (Relu:point {title:'Relu', file_name: file_name})
CREATE (Softrelu:point {title:'Softrelu', file_name: file_name})
CREATE (Bias:point {title:'Bias', file_name: file_name})
CREATE (Weights:point {title:'Weights', file_name: file_name})
CREATE (BatchSize:point {title:'Batch Size', file_name: file_name})
CREATE (LearningRate:point {title:'Learning Rate', file_name: file_name})
CREATE (WhenToStop:point {title:'When to stop', file_name: file_name})
CREATE (LossFunction:point {title:'Loss Function/Fitness Score', file_name: file_name})
CREATE (Gradient:point {title:'Gradient', file_name: file_name})
CREATE (Training:point {title:'Training', file_name: file_name})
CREATE (Newton:point {title:'Newton', file_name: file_name})
CREATE (Genetic:point {title:'Genetic', file_name: file_name})
CREATE (ExpertSystems:point {title:'Expert Systems', file_name: file_name})
CREATE (DataAnalysis:point {title:'Data Analysis', file_name: file_name})
CREATE (Rules:point {title:'Rules/Facts', file_name: file_name})
CREATE (Prolog:point {title:'Prolog', file_name: file_name})
CREATE (Database:point {title:'Symptoms Diagnosis Database', file_name: file_name})
CREATE (MedicalSystems:point {title:'Medical Systems', file_name: file_name})

CREATE
    (AI)-[:consists_of]->(ML),
    (AI)-[:consists_of]->(Algorithms),

    (ML)-[:consists_of]->(Overfitting),
    (ML)-[:consists_of]->(NeuralNetwork),
    (ML)-[:consists_of]->(LossFunction),
    (ML)-[:consists_of]->(Regression),
    (ML)-[:consists_of]->(Data),
    (Regression)-[:consists_of]->(Interpolation),
    (Interpolation)-[:consists_of]->(Regression),

    (Overfitting)-[:consists_of]->(Data),
    (Data)-[:consists_of]->(TrainingData),
    (Data)-[:consists_of]->(EvaluationData),
    (Data)-[:consists_of]->(Text),
    (Data)-[:consists_of]->(Audio),
    (Data)-[:consists_of]->(Image),
    (Data)-[:consists_of]->(MeasuringData),
    (Data)-[:consists_of]->(OtherValues),

    (NeuralNetwork)-[:consists_of]->(Model),
    (NeuralNetwork)-[:consists_of]->(Layer),
    (NeuralNetwork)-[:consists_of]->(BatchSize),
    (NeuralNetwork)-[:consists_of]->(LearningRate),
    (NeuralNetwork)-[:consists_of]->(WhenToStop),
    (NeuralNetwork)-[:consists_of]->(Error),

    (Error)-[:consists_of]->(LossFunction),

    (Layer)-[:consists_of]->(Neuron),
    (Neuron)-[:consists_of]->(Bias),
    (Neuron)-[:consists_of]->(Weights),
    (Neuron)-[:consists_of]->(Activation),

    (Activation)-[:consists_of]->(Step),
    (Activation)-[:consists_of]->(Sigmoid),
    (Activation)-[:consists_of]->(Relu),
    (Activation)-[:consists_of]->(Softrelu),
    
    (LossFunction)-[:consists_of]->(Training),

    (Training)-[:consists_of]->(Gradient),
    (Training)-[:consists_of]->(Newton),
    (Training)-[:consists_of]->(Genetic),

    (Algorithms)-[:consists_of]->(ExpertSystems),
    (Algorithms)-[:consists_of]->(DataAnalysis),
    (Algorithms)-[:consists_of]->(Rules),
    (Algorithms)-[:consists_of]->(Database),
    (Algorithms)-[:consists_of]->(MedicalSystems),
    (Rules)-[:consists_of]->(Prolog)

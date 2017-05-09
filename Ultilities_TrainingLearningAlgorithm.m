function [LearntWeight] = Ultilities_TrainingLearningAlgorithm(trainingDataMatrix, answerMatrix, regularizationLambda)
    %Extract useful parameters
    trainingDataSize = size(trainingDataMatrix);
    trainingDataAmount = trainingDataSize(1);
    trainingDataFeatureAmount = trainingDataSize(2);
    
    %Init the weight matrix
    InitWeight = zeros(trainingDataFeatureAmount+1,1);
   
    CoefficentHelper = ones(trainingDataAmount,1);
    PreparedTrainingData = [CoefficentHelper, trainingDataMatrix];
    
    options = optimset('MaxIter', 100);
    %use fmincg (conjugate gradient method)
     LearntWeight = Utilities_Fmincg (@(t)(Ultilities_LogisticRegression(t, PreparedTrainingData, answerMatrix, regularizationLambda)), InitWeight, options);
end
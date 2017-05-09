%clear everything
clc; clear; close all;

%lambda
baseLambda = 0.003;

calculateLambda = true;

load("Data_Training_FaceDetection.mat");
load("Data_CV_FaceDetection.mat");

trainingDataAmount = size(TrainingDataMatrix,1);
cvDataAmount  = size(CVDataMatrix,1);

trainingCostvsLambda = [];
cvCostvsLambda=[];

while calculateLambda
    
    if(baseLambda > 0.2)
        calculateLambda = false;
    end
    
    lambdaComparedWeight = Ultilities_TrainingLearningAlgorithm(TrainingDataMatrix,TrainingDataAnswerMatrix, baseLambda);
    
    traingHelper = ones(trainingDataAmount,1);
    preparedTrainingMatrix= [traingHelper, TrainingDataMatrix];
    [trainCost, Gradient] = Ultilities_LogisticRegression(lambdaComparedWeight, preparedTrainingMatrix, TrainingDataAnswerMatrix, baseLambda);
    trainingCostvsLambda = [trainingCostvsLambda;[trainCost, baseLambda]];
    
    cvHelper = ones(cvDataAmount, 1);
    preparedCVDataMatrix = [cvHelper, CVDataMatrix];
    [cvCost, Gradient] = Ultilities_LogisticRegression(lambdaComparedWeight, preparedCVDataMatrix, CVDataAnswer, baseLambda); 
    cvCostvsLambda = [cvCostvsLambda;[cvCost, baseLambda]];
    
    baseLambda = baseLambda + 0.003;
    
end

save('Data_Lambda_CVTest.mat', 'trainingCostvsLambda', 'cvCostvsLambda');


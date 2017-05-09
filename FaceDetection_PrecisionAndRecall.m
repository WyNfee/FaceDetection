%This file is used to find the ebsilon of logistic regression

%clear everything
clear; clc; close all;

%load many data
load("Data_Training_FaceDetection.mat");
load('Data_LearntWeight_FaceDetection.mat');
load('Data_CV_FaceDetection.mat');

%judge filter
epsilon = 0.8;

%compute the predict result of Training Data;
trainingDataSize = size(TrainingDataMatrix,1);
trainingDataHelper = ones(trainingDataSize,1);
trainingDataHelperMatrix = [trainingDataHelper, TrainingDataMatrix];

%Training Data Prediction
predictionTrainingData = Utilities_Sigmoid(trainingDataHelperMatrix * learntWeight);
predictionTrainingData  = predictionTrainingData>epsilon;

%Judge parameters
trainingTruePositive = sum((predictionTrainingData + TrainingDataAnswerMatrix) == 2);
trainingFalsePositive = sum((predictionTrainingData - TrainingDataAnswerMatrix) == 1);
trainingTrueNegative = sum((predictionTrainingData + TrainingDataAnswerMatrix) == 0);
trainingFalseNegative = sum((predictionTrainingData - TrainingDataAnswerMatrix == -1));

%Print output
trainingPrecision = trainingTruePositive / (trainingTruePositive + trainingFalsePositive);
trainingRecall = trainingTruePositive/ (trainingTruePositive + trainingFalseNegative);
fprintf("The Precision of Training is %2.2f \n", trainingPrecision);
fprintf("The Recall of Training is %2.2f \n", trainingRecall);

%compute cv data
cvDataSize = size(CVDataMatrix,1);
cvDataHelper = ones(cvDataSize,1);
cvDataHelperMatrix = [cvDataHelper, CVDataMatrix];

%cv data prediction
predictionCVData = Utilities_Sigmoid(cvDataHelperMatrix * learntWeight);
predictionCVData = predictionCVData > epsilon;

%judge parameters
cvTruePositive = sum((predictionCVData+CVDataAnswer) == 2);
cvTrueNegative = sum((predictionCVData+CVDataAnswer) == 0);
cvFalsePositive = sum((predictionCVData-CVDataAnswer) == 1);
cvFalseNegative = sum((predictionCVData-CVDataAnswer) == -1);

%Print output
cvPrecision = cvTruePositive / (cvTruePositive + cvFalsePositive);
cvRecall = cvTruePositive / (cvTruePositive + cvFalseNegative);
cvF1Score =  2 * cvPrecision * cvRecall / (cvRecall + cvPrecision);
fprintf("The Precision of CV is %2.2f \n", cvPrecision);
fprintf("The Recall of CV is %2.2f \n", cvRecall);
fprintf("The F1 Score of CV is %2.2f \n", cvF1Score);


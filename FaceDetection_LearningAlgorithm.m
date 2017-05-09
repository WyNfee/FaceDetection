%The Core Learning Algorithm for Face Detection;
%Using Logistic Regression
%Using Linear Learning Model

%clear everything
clear; clc; close all;

%load prepared data
load('Data_Training_FaceDetection.mat');

%The code below is detecting the learning algorithm's correctness

%theta_t = [-2; -1; 1; 2];
%X_t = [ones(5,1) reshape(1:15,5,3)/10];
%y_t = ([1;0;1;0;1] >= 0.5);
%lambda_t = 3;
%[J grad] = Ultilities_LogisticRegression(theta_t, X_t, y_t, lambda_t);
%J
%grad

%judge filter; check FaceDetection_PrecisionAndRecall.m file
epsilon = 0.8;

%the lambda of regularization parameter, check FaceDetection_LambdaChoose.m
%and FaceDetection_LambdaPlot.m
lambda =  0.036;
learntWeight = Ultilities_TrainingLearningAlgorithm(TrainingDataMatrix, TrainingDataAnswerMatrix, lambda);

TrainingAmount = size(TrainingDataMatrix,1);

%Do Prediction after we get the lambda
for index = 1: TrainingAmount
    s = input('Press enter to display a image, q to exit:','s');
    if(s == 'q')
        break;
    end
    
    i = rand(1,1) * TrainingAmount;
    i = round(i);
    
    pickedImageMatrix = TrainingDataMatrix(i,:);
    imageMatrix = reshape(pickedImageMatrix, imageHeight,imageWidth);
    pickedImageMatrix = [1, pickedImageMatrix];
   
    colormap(gray);
    imagesc(imageMatrix);
    axis image off;
    if(Utilities_Sigmoid(pickedImageMatrix * learntWeight) > 0.8)
        title('Predict Face: True');
    else
        title('Predict Face: False');
    end
    drawnow;
    
end

s = input('Press y to save weight to data file:','s');
if(s == 'y')
    save('Data_LearntWeight_FaceDetection.mat','learntWeight');
end
%clear everything
clc; clear; close all;

%Data Lambda CVTest 
load("Data_Lambda_CVTest.mat");

figure
plot(trainingCostvsLambda(:,2),trainingCostvsLambda(:,1));
hold on
plot(cvCostvsLambda(:,2),cvCostvsLambda(:,1));
title('Cost vs. Lambda Plot');
xlabel('Error');
ylabel('lambda');
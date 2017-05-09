function [Cost, Gradient] = Ultilities_LogisticRegression(inputWeight, preparedTrainingDataMatrix, answerMatrix, regularizelambda)
    
    %training data amount;
    trainingDataAmount = length(answerMatrix);

    %separete the whole formula into small pieces
    z = preparedTrainingDataMatrix * inputWeight;
    hypothesis = Utilities_Sigmoid(z);
    
    positivePart = -answerMatrix .* log(hypothesis);
    negativePart = -(1 - answerMatrix) .* log(1-hypothesis);
    
    %regularizedForm Helper
    featureAmount = length(inputWeight);
    regularizedFormHelper = ones(featureAmount,1);
    regularizedFormHelper(1) = 0;
    regularizedWeight = regularizedFormHelper.*inputWeight;
    
    %Compute the Cost
    %Compute the cost without regularized form
    Cost = sum((positivePart + negativePart))/trainingDataAmount;
    %regularized form
    regularizedFormForCost = sum(regularizedWeight.^2) * regularizelambda/ (2 * trainingDataAmount);
    %Final Cost
    Cost = Cost + regularizedFormForCost;
    
    %Compute the Graident
    Gradient = sum((hypothesis - answerMatrix) .* preparedTrainingDataMatrix)/trainingDataAmount;
    regularizedFormForWeight = regularizelambda .* regularizedWeight' / trainingDataAmount;
    Gradient = Gradient + regularizedFormForWeight;
    
    Gradient = Gradient(:);
end
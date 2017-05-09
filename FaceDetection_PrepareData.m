%clear all, clean all
clear; close all; clc;

%training data Weigth/Height
imageWidth = 100;
imageHeight = 150;
%Each pixel represent a feature
FeatureAmount = imageWidth * imageHeight;

%Hard coded data amount, coresponding to training data amount
PositiveFaceDataAmount  = 45;
NegativeFaceDataAmount = 43;
FaceDataAmount = PositiveFaceDataAmount+NegativeFaceDataAmount;
NotFaceDataAmount = 98;
TotalTrainingSampleAmount = NotFaceDataAmount + FaceDataAmount;

%Create training data matrix
TrainingDataMatrix = zeros(TotalTrainingSampleAmount, FeatureAmount);

%Init the Face answer matrix
PositiveFaceAnswerMatrix = ones(FaceDataAmount, 1);
NegativeFaceAnserMatrix = zeros(NotFaceDataAmount, 1);
TrainingDataAnswerMatrix = [PositiveFaceAnswerMatrix;NegativeFaceAnserMatrix];

%Load the Face Data

%Load the Taget Face Data
for index = 1 : PositiveFaceDataAmount

    %datafilelocaltion
    filenamestring = sprintf("TrainingData\\Face\\Positive\\%d.bmp", index);
    filename = char(filenamestring);

    outputMatrix = Utilities_LoadImageToMatrix(filename, FeatureAmount);
    % Store them in a generic array
    TrainingDataMatrix(index,:) = outputMatrix;  
end

%Load the Negative Face Data
for index = 1 : NegativeFaceDataAmount
    %build the file name
    filenamestring = sprintf("TrainingData\\Face\\Negative\\%d.bmp", index);
    filename = char(filenamestring);

    outputMatrix =  Utilities_LoadImageToMatrix(filename, FeatureAmount);
    % Store them in a generic array
    TrainingDataMatrix(PositiveFaceDataAmount + index,:) = outputMatrix;  
end

%Load the Not Face Data
for index = 1 :NotFaceDataAmount
    %build the file name
    filenamestring = sprintf("TrainingData\\NotFace\\%d.bmp", index);
    filename = char(filenamestring);
    
    outputMatrix = Utilities_LoadImageToMatrix(filename, FeatureAmount);
    % Store them in a generic array
    TrainingDataMatrix(FaceDataAmount + index,:) = outputMatrix;  
end

%Plot the data to check
for index = 1: TotalTrainingSampleAmount
    s = input('Press enter to display a image, q to exit:','s');
    if(s == 'q')
        break;
    end
    
    i = round(rand(1,1)*TotalTrainingSampleAmount);
    
    pickedImageMatrix = TrainingDataMatrix(i,:);
    imageMatrix = reshape(pickedImageMatrix, imageHeight,imageWidth);
    
    colormap(gray);
    imagesc(imageMatrix);
    axis image off;
    
    if(TrainingDataAnswerMatrix(i) == 1)
        title('Face');
    else
        title('No Face');
    end
    
    drawnow;
end

%Save Data to File
s = input('Press y to save image to data file:','s');
if(s == 'y')
    save('Data_Training_FaceDetection.mat','TrainingDataMatrix','TrainingDataAnswerMatrix','FaceDataAmount','imageHeight','imageWidth');
end










%Preview the learnt weight's performance on CV data
%Extract CV from the data

%clear everything
clear; clc; close all;

%load weight
load("Data_LearntWeight_FaceDetection.mat");

%training data Weigth/Height
imageWidth = 100;
imageHeight = 150;
%Each pixel represent a feature
FeatureAmount = imageWidth * imageHeight;

%Data Amount
positiveCVDataAmount =10;
negativeCVDataAmount =10;
FaceCVDataAmount = positiveCVDataAmount + negativeCVDataAmount;

notfaceCVDataAmount = 10;

TotalCVDataAmount = FaceCVDataAmount+notfaceCVDataAmount;

%Create training data matrix
CVDataMatrix = zeros(TotalCVDataAmount, FeatureAmount);
CVFaceDataAnswer = ones(FaceCVDataAmount, 1);
CVNoFaceDataAnswer = zeros(notfaceCVDataAmount, 1);
CVDataAnswer = [CVFaceDataAnswer;CVNoFaceDataAnswer];

%Load the Taget Face Data
for index = 1 : positiveCVDataAmount

    %datafilelocaltion
    filenamestring = sprintf("CVData\\Face\\Positive\\%d.bmp", index);
    filename = char(filenamestring);

    outputMatrix = Utilities_LoadImageToMatrix(filename, FeatureAmount);
    % Store them in a generic array
    CVDataMatrix(index,:) = outputMatrix;  
end

%Load the Taget Face Data
for index = 1 : negativeCVDataAmount

    %datafilelocaltion
    filenamestring = sprintf("CVData\\Face\\Negative\\%d.bmp", index);
    filename = char(filenamestring);

    outputMatrix = Utilities_LoadImageToMatrix(filename, FeatureAmount);
    % Store them in a generic array
    CVDataMatrix(positiveCVDataAmount+index,:) = outputMatrix;  
end

%Load the Taget Face Data
for index = 1 : notfaceCVDataAmount

    %datafilelocaltion
    filenamestring = sprintf("CVData\\NoFace\\%d.bmp", index);
    filename = char(filenamestring);

    outputMatrix = Utilities_LoadImageToMatrix(filename, FeatureAmount);
    % Store them in a generic array
    CVDataMatrix(FaceCVDataAmount+index,:) = outputMatrix;  
end


%Do preview prediction on CV Data
%Plot the data to check
for index = 1: TotalCVDataAmount
    s = input('Press enter to display a image, q to exit:','s');
    if(s == 'q')
        break;
    end
    
    i = round(rand(1,1)*TotalCVDataAmount);
    
    pickedImageMatrix = CVDataMatrix(i,:);
    imageMatrix = reshape(pickedImageMatrix, imageHeight,imageWidth);
    pickedImageMatrix = [1,pickedImageMatrix];
    
    colormap(gray);
    imagesc(imageMatrix);
    axis image off;
    
    z = pickedImageMatrix * learntWeight;
    prediction = Utilities_Sigmoid(z)
    
    if(prediction > 0.8)
        title('Face');
    else
        title('No Face');
    end
   
    drawnow;
end



s = input('Press y to CVData to file:','s');
if(s == 'y')
    save('Data_CV_FaceDetection.mat','CVDataMatrix','CVDataAnswer');
end









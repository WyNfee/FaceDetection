%Get Data from Test Folder and Test it
%Extract CV from the data

%clear everything
clear; clc; close all;

%load learnt weight
load("Data_LearntWeight_FaceDetection.mat");

%training data Weigth/Height
imageWidth = 100;
imageHeight = 150;
FeatureAmount = imageWidth * imageHeight;

while true
     s = input('Input the file name in Test Data Directory, and q to exit:','s');
    if(s == 'q')
        break;
    end
    
    %load Image File
    filenamestring = sprintf("TestData\\%s.bmp", s);
    filename = char(filenamestring);
    
    outputMatrix = Utilities_LoadImageToMatrix(filename, FeatureAmount);
    imageMatrix = reshape(outputMatrix, imageHeight,imageWidth);
    outputMatrix = [1,outputMatrix];
    
    colormap(gray);
    imagesc(imageMatrix);
    axis image off;
    
    z = outputMatrix * learntWeight;
    prediction = Utilities_Sigmoid(z);
    
    if(prediction > 0.8)
        title('Face');
    else
        title('No Face');
    end
   
    drawnow;
end
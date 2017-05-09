function [imageMatrix] =  Utilities_LoadImageToMatrix(imageFileName, dataMatrixSize)
    % read image data from file and convert to image data
    image = imread(imageFileName);
    number =im2double(image);
    
    %Pick the mean of three channels
    imageMatrix = (number(:,:,1) + number(:,:,2) + number(:,:,3))/3;

    % convert to an array
    imageMatrix = reshape(imageMatrix, 1,dataMatrixSize);
    
    
end
%clear everything
clear; clc; close all;

load("Data_LearntWeight_FaceDetection.mat");

%pattern matrix parameters
patternImageWidth = 100;
patternImageHeight = 150;
patternMatrixSize = patternImageWidth * patternImageHeight;

%sliding window step
windowSlideStepWidth = 4;
windowSlideHeight = 4;

%debug purpose
debug = 0;

while true
     s = input('Input the file name in Test Data Directory, and q to exit:','s');
    if(s == 'q')
        break;
    end
    
    %flag of find faces
    findFace = false;
    
    %load Image File
    filenamestring = sprintf("TestData\\%s.bmp", s);
    filename = char(filenamestring);

    image = imread(filename);
    [imageHeight, imageWidth, imageDepth] = size (image);
    
    %normalize to [-1;1]
    number =im2double(image);
    imageMatrix = (number(:,:,1) + number(:,:,2) + number(:,:,3))/3;
    
    %a window, store the position where we find the face, and prediction of
    %it
    detectionWindow = [];
    
    scalefactor = 0.5;

    while scalefactor < 5
        
        %reset it for every loop
        %Current window Pos and Height
        currentWindowPosW = 0;
        currentWindowPosH = 0;
        %A loop to slide the windowdetermine to slide the window 
        while (currentWindowPosW + (patternImageWidth * scalefactor) <= imageWidth)
            
            %reset the Height position for each update of width iteration
            currentWindowPosH = 0;
            
            while(currentWindowPosH + (patternImageHeight * scalefactor) <= imageHeight)   
                %do the window clamp
                windowedMatrix = imageMatrix(currentWindowPosH+1 : currentWindowPosH+(patternImageHeight * scalefactor), currentWindowPosW+1: currentWindowPosW+(patternImageWidth * scalefactor));
                %do simple central point resize(easy apporach) blinear, should sufficient
                windowedMatrix = Ultilities_ResizeImageMatrix(windowedMatrix, [patternImageHeight, patternImageWidth]);
                reshapedwindowedMatrix = reshape(windowedMatrix, 1,patternMatrixSize);

                %compute whether clamped part is target face
                outputMatrix = [1, reshapedwindowedMatrix];
                prediction = outputMatrix * learntWeight;
                prediction = Utilities_Sigmoid(prediction);
                actualPredict = prediction;
                % >_<!! use simple linear method, causing much trouble, let
                % make it higher precision
                prediction = prediction > 0.98;
                
                %if we predict this image is a face image
                if(prediction == 1)
                   window = [currentWindowPosW+1, currentWindowPosH+1, scalefactor, actualPredict];
                   detectionWindow = [detectionWindow; window];
                   findFace = true; 

                   %debug purpose, check the image
                   if(debug == 1)
                       colormap(gray);
                       imagesc(windowedMatrix);
                       axis image off;
                   end
                   
                end
                
                %do height update
                currentWindowPosH = currentWindowPosH + windowSlideHeight;
            end
                %do width update
                currentWindowPosW = currentWindowPosW + windowSlideStepWidth;
        end
        
        %step the scale factor to better detect
        scalefactor = scalefactor + 0.5;
        
    end
    
    if(findFace)
        %Plot detection area
        [maxprediction, index] = max(detectionWindow(:,4));
        bestFacePosW = detectionWindow(index,1);
        bestFacePosH = detectionWindow(index,2);
        bestscale = detectionWindow(index,3);

        %the rect thickness
        detectionRectThickness = 4;

        %determin where to draw the rectangle
        faceDetectionStart = [bestFacePosW, bestFacePosH];
        faceDetectionEnd = [bestFacePosW+ (patternImageWidth * bestscale), bestFacePosH + (patternImageHeight * bestscale)];

        %backup the image matrix
        faceDetectionMatrix = imageMatrix;

        %draw the rectangle
        faceDetectionMatrix(faceDetectionStart(2) : faceDetectionEnd(2), faceDetectionStart(1) : faceDetectionStart(1) + detectionRectThickness) = 1;
        faceDetectionMatrix(faceDetectionStart(2) : faceDetectionEnd(2), faceDetectionEnd(1) -  detectionRectThickness : faceDetectionEnd(1)) = 1;
        faceDetectionMatrix(faceDetectionStart(2) : faceDetectionStart(2)+detectionRectThickness , faceDetectionStart(1) : faceDetectionEnd(1)) = 1;
        faceDetectionMatrix(faceDetectionEnd(2) - detectionRectThickness : faceDetectionEnd(2) , faceDetectionStart(1) : faceDetectionEnd(1)) = 1;

        colormap(gray);
        imagesc(faceDetectionMatrix);
        title('Find Face');
        axis image off;
    else
        colormap(gray);
        imagesc(imageMatrix);
        title('No Face');
        axis image off;
    end
    
    
end






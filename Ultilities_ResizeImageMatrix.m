function [outputImageMatrix]  = Ultilities_ResizeImageMatrix(inputImage, outputSize)
    oldSize = size(inputImage);                   %# Get the size of your image
    newSize = outputSize;
    scale = newSize./oldSize;

    %# Compute an upsampled set of indices:
    % this approach is a simple one, just find the neareast point after
    % scale
    rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
    colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));

    %# Index old image to get new image:

    outputImageMatrix = inputImage(rowIndex,colIndex,:);
end
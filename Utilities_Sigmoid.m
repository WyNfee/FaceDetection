function output = Utilities_Sigmoid(input)
    output = 1.0 ./ (1.0+exp(-input));
end
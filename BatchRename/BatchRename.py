import os

print("Batch Rename Image Data");
print("Make sure the data is correctly placed");
print("Press 1 to rename TrainingData/Face/Postive image");
print("Press 2 to rename TrainingData/Face/Negative image");
print("Press 3 to rename TrainingData/NoFace image");
print("Press 4 to rename CVData/Face/Postive image");
print("Press 5 to rename CVData/Face/Negative image");
print("Press 6 to rename CVData/NoFace image");
print("Press other keys to exit");

getinput = True;

while getinput:
    key = input("Press the key to continue: ");
    try:
        key = int(key);
    except ValueError:
        quit();

    if (key == 1):
        path = '/Users/wangy/Documents/GitHub/FaceDetection/FaceDetectionAndIdentification/TrainingData/Face/Positive/';
        files = os.listdir(path);
        i = 1
        for file in files:
            os.rename(os.path.join(path, file), os.path.join(path, str(i)+'.bmp'));
            i = i+1;
        print("Process Complete");
    if (key == 2):
        path = '/Users/wangy/Documents/GitHub/FaceDetection/FaceDetectionAndIdentification/TrainingData/Face/Negative/';
        files = os.listdir(path);
        i = 1
        for file in files:
            os.rename(os.path.join(path, file), os.path.join(path, str(i)+'.bmp'));
            i = i+1;
        print("Process Complete");
    if (key == 3):
        path = '/Users/wangy/Documents/GitHub/FaceDetection/FaceDetectionAndIdentification/TrainingData/NoFace/';
        files = os.listdir(path);
        i = 1
        for file in files:
            os.rename(os.path.join(path, file), os.path.join(path, str(i)+'.bmp'));
            i = i+1;
        print("Process Complete");
    if (key == 4):
        path = '/Users/wangy/Documents/GitHub/FaceDetection/FaceDetectionAndIdentification/CVData/Face/Positive/';
        files = os.listdir(path);
        i = 1
        for file in files:
            os.rename(os.path.join(path, file), os.path.join(path, str(i)+'.bmp'));
            i = i+1;
        print("Process Complete");
    if (key == 5):
        path = '/Users/wangy/Documents/GitHub/FaceDetection/FaceDetectionAndIdentification/CVData/Face/Negative/';
        files = os.listdir(path);
        i = 1
        for file in files:
            os.rename(os.path.join(path, file), os.path.join(path, str(i)+'.bmp'));
            i = i+1;
        print("Process Complete");
    if (key == 6):
        path = '/Users/wangy/Documents/GitHub/FaceDetection/FaceDetectionAndIdentification/CVData/NoFace/';
        files = os.listdir(path);
        i = 1
        for file in files:
            os.rename(os.path.join(path, file), os.path.join(path, str(i)+'.bmp'));
            i = i+1;
        print("Process Complete");
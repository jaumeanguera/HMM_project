function [audios_train,audios_test] = getListFiles(pathToClass)
% GETLISTFILES first generates a list with the names of all the recordings
% in the path specified in 'pathToClass'. Then it separates all the audios
% into training data (80%) and test data (20%)

% Define percentage training data
percentageTrainData = 0.8; % percentageTestData = 1 - percentageTrainData;

% Create a list with all the fileNames in the path pathToClasses/class, 
% which contains all the audios of the class specified in the input
audios = dir([pathToClass,'*.*']);
fileNames = audios(~ismember({audios.name},{'.','..','.DS_Store'}));

% Calculate number of audios in the training data
lenAudios = length(fileNames);
lenTrainData = round(lenAudios*percentageTrainData);

% Generate list of audio names for set of training and set of test data
audios_train = fileNames(1:lenTrainData);
audios_test = fileNames(lenTrainData+1:end);

end
clc;
clear;
close all;

% Relative path where the audios for all the classes are stored
pathToClasses = '../../sample_recordings/';

% Define vector with all possible classes
%classes = {'down','off'}; 
classes = {'up';'on';'off';'right'};
% {'down','up','on,'off','right','left','yes','no','wow','one'};
nClasses = length(classes);

% Parameters to generate HMM and store output
nStates = [15;11;4;12];
hmm_classes = cell(nClasses,1);

% Parameters to store features of the train and test data
features_train = cell(nClasses,1);   % MFCC features train data
features_test = cell(nClasses,1);    % MFCC features test data
lFeatures_train = cell(nClasses,1);  % Length sub-sequences train data
lFeatures_test = cell(nClasses,1);   % Length sub-sequences test data

% Parameter to store test results
probObsData = cell(nClasses,1);
listIndClasses = cumsum([1,nClasses*ones(1,nClasses)]);

% Check that parameters are correct
assert(length(nStates)==nClasses,'Each class must have a specific nSates');
assert(nClasses>=2||nClasses<=10,'Incorrect number of classes');

% Generate HMM for each class
for k = 1:nClasses
    
    % Define path where all the recordings of the class are stored
    pathToClass = [pathToClasses,classes{k},'/'];
    
    % Get training and test data for the specific class
    [audios_train,audios_test] = getListFiles(pathToClass);
    
    % Get features for the training and the testing data
    [obsData_train,lData_train] = getFeaturesPath(pathToClass,audios_train);
    [obsData_test,lData_test] = getFeaturesPath(pathToClass,audios_test);
    
    % Store features
    features_train{k} = obsData_train;
    features_test{k} = obsData_test;
    lFeatures_train{k} = lData_train;
    lFeatures_test{k} = lData_test;
    
    % Generate HMM using training data
    hmm_classes{k} = MakeLeftRightHMM(nStates(k),GaussMixD,obsData_train,lData_train);
    
    fprintf('HMM for class ''%s'' has been correctly created\n',classes{k});

end


% Get performance results for all possible combinations
nAudios_test = length(lData_test);
for k = 1:nClasses
    
    % Allocate space to store P( X = data_test(l) | HMM(k) )
    probObsData_test = zeros(nAudios_test,nClasses);
    
    for l = 1:nClasses
        % Compute P( X = data_test(l) | HMM(k) )
        probObsData_test(:,l) = getProbObsData(hmm_classes{k}, ...
                                features_test{l},lFeatures_test{l});
    end
    
    probObsData{k} = probObsData_test;
    
end

% Get accuracy classification                          
accuracy = getPerformanceResults(probObsData,classes);

function [obsData,lData] = getFeaturesPath(pathToClass,audios)
% GETFEATURESPATH calculates the feature-vector observations for all the
% audios within the list of audio file names 'audios'. Each of these
% recordings audios are stored in the path specified in 'pathToClass'.

% Define parameters to generate and store all features
winlength = 0.03;             % Window length for the spectrogram in seconds
ncep = 13;                    % Number of cepstrogram coefficients
nfeatures = (ncep-1)*3;       % Number of features (mfcc, mfcc_delta, mfcc_delta2)
lenAudios = length(audios);   % Number of audios recordings for generating HMM
X = zeros(nfeatures,1);       % Create dummy matrix to store observed data
lData = zeros(1,lenAudios);   % Vector with lenghts of audio sub-sequences

% Get features for each audio file
for l = 1:lenAudios;
    
    % Define relative path to the audio (including audio name)
    pathToAudio = [pathToClass,audios(l).name];
    
    % Obtain all the features of the selected audio
    [obsAudio,lDataAudio] = getFeatures(pathToAudio,winlength,ncep);
    
    % Store features (mfcc, mfcc_delta, mfcc_delta2) to the matrix obsData
    X = [X obsAudio];
    
    % Store the length of the features into the vector lData
    lData(l) = lDataAudio;
    
end

% Delete dummy data from X and save result to the obsData matrix
obsData = X(:,2:end);

end

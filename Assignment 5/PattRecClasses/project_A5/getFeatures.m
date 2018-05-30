function [obsAudio,lDataAudio] = getFeatures(pathToAudio,winlength,ncep)
% GETFEATURES calculates the features of one specific audio file given the
% parameters winlength and ncep for the cepstrogram. The output 'obsAudio'
% consists of a matrix containing the MFCC, the first derivative of the 
% MFCC, and the second derivative of the MFCC. The output 'lDataAudio' is
% an integer indicating the number of columns in the matrix 'obsAudio' -  
% that is, the number of feature-vector observations during all the 
% duration of the audio recording.

% Read audio file
[sig_audio,fs_audio] = audioread(pathToAudio);

% Get cepstrogram
[mfccs] = GetSpeechFeatures(sig_audio,fs_audio,winlength,ncep);

% Normalize MFCC to have zero mean and unit variance
mfccs_norm = zscore(mfccs(2:end,:),0,1);

% Compute first derivative
mfccs_delta = transpose(diff(mfccs_norm'));
mfccs_delta = [zeros(size(mfccs_delta,1),1), mfccs_delta];

% Compute second derivative
mfccs_delta2 = transpose(diff(mfccs_delta'));
mfccs_delta2 = [zeros(size(mfccs_delta2,1),1), mfccs_delta2];

% Generate output variables
%obsAudio = [mfccs_norm;mfccs_delta;mfccs_delta2];
obsAudio = [mfccs_norm;mfccs_delta;mfccs_delta2];
lDataAudio = size(obsAudio,2);

end

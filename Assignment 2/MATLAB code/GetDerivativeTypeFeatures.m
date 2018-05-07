function [ mfccs_delta, mfccs_delta2 ] = GetDerivativeTypeFeatures(mfccs)
% GETDERIVATIVETYPEFEATURES is created to obtain more information than the
% one provided by GetSpeechFeatures. Specifically, the function extracts
% relative differences in acoustic properties by estimating the time
% derivative and second derivative of each MFCC at each point in time. The
% input to the function is the normalized MFCC, and the outputs are the
% first derivative and the second derivative of MFCC. All input and outputs
% have the same dimensions.
%
% Input:
% mfccs= matrix containing mel frequency cepstral coefficients for use
%        as features in speech recognition. Each column corresponds to
%        the cepstral coefficients of a single frame, with the zeroth
%        order coefficent at the top.
%
% Output:
% mfccs_delta=   First derivative of MFCC
% mfccs_delta2=  Second derivative of MFCC
%
%----------------------------------------------------
%Code Authors: Ashutosh Vaishnav and Jaume Anguera Peris 
%----------------------------------------------------


% Normalize MFCC to have zero mean and unit variance
mfccs_norm = zscore(mfccs(2:end,:),0,1);

% Compute first derivative
mfccs_delta = transpose(diff(mfccs_norm'));
mfccs_delta = [zeros(size(mfccs_delta,1),1), mfccs_delta];

% Compute second derivative
mfccs_delta2 = transpose(diff(mfccs_delta'));
mfccs_delta2 = [zeros(size(mfccs_delta2,1),1), mfccs_delta2];

end


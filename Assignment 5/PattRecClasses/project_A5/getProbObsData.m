
function Prob = getProbObsData(hmm,obsData,lData)
% GETPROBOBSDATA calculates the probability P( X = obsData | HMM ) - that
% is, the probability that the observed data in 'obsData' belongs to the
% Hidden Markov Model 'hmm'. The input parameter 'obsData' is a matrix
% containing the vector-features at all time instances (sub-sequences) for
% all the audios. The length of each sub-sequence is specified in the input
% parameter 'lData'.


ind = cumsum([1,lData]);     % Index where each sub-sequence starts
lenAudios = length(lData);   % Number of audios to be tested
Prob = zeros(lenAudios,1);   % Allocate space to store probabilities

for k = 1:lenAudios
    % Compute P( X = obsData(k) | HMM ) and store the results column-wise,
    % where each k index represents the audio with all lData(k)
    % feature-vectors
    Prob(k) = hmm.logprob(obsData(:,ind(k):ind(k+1)-1));
end

end


%logP=logprob(hmm,x) gives conditional log(probability densities)
%for an observed sequence of (possibly vector-valued) samples,
%for each HMM object in an array of HMM objects.
%This can be used to compare how well HMMs can explain data from an unknown source.
%
%Input:
%hmm=   array of HMM objects
%x=     matrix with a sequence of observed vectors, stored columnwise
%NOTE:  hmm DataSize must be same as observed vector length, i.e.
%       hmm(i).DataSize == size(x,1), for each hmm(i).
%       Otherwise, the probability is, of course, ZERO.
%
%Result:
%logP=  array with log probabilities of the complete observed sequence.
%logP(i)=   log P[x | hmm(i)]
%           size(logP)== size(hmm)
%
%The log representation is useful because the probability densities
%exp(logP) may be extremely small for random vectors with many elements
%
%Method: run the forward algorithm with each hmm on the data.
%
%Ref:   Arne Leijon (20xx): Pattern Recognition.
%
%----------------------------------------------------
%Code Authors: Ashutosh Vaishnav and Jaume Anguera Peris
%----------------------------------------------------

function logP=logprob(hmm,x)

hmmSize = size(hmm);    % size of hmm array
T = size(x,2);          % number of vector samples in observed sequence
logP = zeros(hmmSize);  % space for result

for i = 1:numel(hmm)    % for all HMM objects
    % Note: array elements can always be accessed as hmm(i),
    % regardless of hmmSize, even with multi-dimensional array.
    %
    % logP(i)= result for hmm(i)
    % continue coding from here, and delete the error message.
    
    % Select one HMM
    h = hmm(i);
    
    % Create a matrix to allocate the state-conditional likelihood values.
    % For infinite-duration HMM, nStates = N, and, for finite-duration HMM,
    % nStates = N+1
    pX = zeros(h.nStates,T);
    
    % Compute pX(j,t)= P( X(t)= observed x(t) | S(t)= j ) for all sources
    % j = 1...nStates, all all time instants t = 1...T
    for j=1:h.nStates
        pX(j,:) = h.OutputDistr(j).prob(x);
    end
    
    % Call the forward algorithm to obtain c(t) for t = 1...T
    [~,c] = h.StateGen.forward(pX);
    
    % Compute log[ P( X(1)...X(T) | HMM ) ]
    logP(i) = sum(log(c));
    
end;
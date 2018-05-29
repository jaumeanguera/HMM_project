function [ Prob ] = testHMM( hmm,obsData )
%TESTHMM Summary of this function goes here
%   Detailed explanation goes here

Prob = hmm.logprob(obsData);

end


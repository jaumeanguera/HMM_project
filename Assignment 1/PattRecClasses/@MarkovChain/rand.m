function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%---------------------------------------------
%Code Authors:
%---------------------------------------------

S=zeros(1,T);%space for resulting row vector
nS=mc.nStates;

S = zeros(T,1) -1;    %Modify this for finite duration Markov chain
S(1) = randsrc(1,1,[1:nS;mc.InitialProb']);
for i=2:T
    if S(i-1)<= nS
        S(i) = randsrc(1,1,[1:nS;mc.TransitionProb(S(i-1),:)]);
    else
        break;
    end
end
S = S(S>0);
%error('Method not yet implemented');
%continue code from here, and erase the error message........



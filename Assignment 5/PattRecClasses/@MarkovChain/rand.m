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
%Code Authors: Ashutosh Vaishnav and Jaume Anguera Peris
%---------------------------------------------

S = zeros(1,T) - 1;     %space for resulting row vector
nS = mc.nStates;

%continue code from here, and erase the error message........

% Chech if the Markov Chain has FINITE duration.
isFINITE = mc.finiteDuration();

% Assign the first value of the Markov Chain based on the initial
% probabilities mc.InitialProb ('q' vector in lecture notes)
S(1) = randsrc(1,1,[1:nS;mc.InitialProb']);

if isFINITE
    
    for k = 2:T

        if (S(k-1) > nS)
            % If the previous element in the sequence was the END state, 
            % stop the for-loop and take only the valid values of S.
            % This will result in having length(S) <= T.
            S = S(S>0);
            S = S(1:end-1);
            break;
        end

        % When the MarkovChain has FINITE duration but we have not found 
        % the END state yet, we continue generating the random state 
        % sequence based on the transaction probabilities
        % mc.TransitionProb ('A' matrix in the lecture notes)
        S(k) = randsrc(1,1,[1:nS+1;mc.TransitionProb(S(k-1),:)]);

    end
    
else
    
    for k = 2:T

        % When the MarkovChain has INFINITE duration, we run the for-loop
        % to generate the random state sequence based on the transaction 
        % probabilities mc.TransitionProb ('A' matrix in the lecture 
        % notes). Note that in the INFINITE case, the range of correct
        % states goes from 1 to nS, whereas in the FINITE case, the range 
        % of correct states goes from 1 to nS+1.
        S(k) = randsrc(1,1,[1:nS;mc.TransitionProb(S(k-1),:)]);

    end
    
end


clc;
close all;

% Third assignment Pattern Recognition and Machine Learning Project
% Authors: Ashutosh Vaishnav and Jaume Anguera Peris
% A.3 Algorithm Implementation


%% ---------------- Forward Algorithm HMM ----------------
% FINITE or INFINITE Markov Chain?
HMM_type = 'FINITE';
%HMM_type = 'INFINITE';

% General parameters for the Markov Chain
if strcmp(HMM_type,'FINITE')
    % FINITE-duration HMM
    p_initial = [1; 0];                   % Initial probability
    A_initial = [0.9 0.1 0; 0 0.9 0.1];   % Transition probability 
else
    % INFINITE-duration HMM
    p_initial = [1; 0];                   % Initial probability
    A_initial = [0.9 0.1;0.1 0.9];        % Transition probability
end

% Generate Markov Chain model
mc = MarkovChain(p_initial, A_initial);   % State generator
    
% Define HMM with Gaussian output
g1 = GaussD('Mean',0,'StDev',1);          % Distribution for state = 1
g2 = GaussD('Mean',3,'StDev',2);          % Distribution for state = 2
h  = HMM(mc, [g1; g2]);                   % The HMM

% Observed finite-duration feature sequence
x = [-0.2, 2.6, 1.3];

% Get a matrix with state-conditional likelihood values
% pX contains scaled probabilities
pX = h.OutputDistr.prob(x);

% Compute forward algorithm
[alphaHat,c] = forward(mc,pX);

% Test logprob function 
Prob = h.logprob(x);

% Show results
fprintf('Matrix with state-conditional likelihood values: \n');
fprintf('\nalphaHat = \n\n');
disp(alphaHat);
fprintf('\nRow vector with observation probabilities c(t): \n');
fprintf('\nc = \n\n');
disp(c);
fprintf('\nLog-probability of the observation probabilities vector: \n');
fprintf('\nProb = \n\n');
disp(Prob);



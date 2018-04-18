
clc;
close all;

% A.1 HMM Signal Source
%% INFINTE Markov Chain
% General parameters 
p_initial = [0.5; 0.5];                   % Initial probability
A_initial = [0.8 0.2; 0.05 0.95];         % Transition probability
mc = MarkovChain(p_initial, A_initial);   % State generator

% Define HMM with Discrete output
g1 = DiscreteD([1;0]);                    % Distribution for state = 1
g2 = DiscreteD([0;1]);                    % Distribution for state = 2
h  = HMM(mc, [g1; g2]);                   % The HMM
[X_DiscreteD,S_DiscreteD] = rand(h, 100); % Generate an output sequence


%% FINITE Markov Chain
% General parameters 
p_initial = [0.5; 0.5];                   % Initial probability
A_initial = [0.8 0.1 0.1; 0.05 0.85 0.1]; % Transition probability
mc = MarkovChain(p_initial, A_initial);   % State generator

% Define HMM with Gaussian output
g1 = GaussD('Mean',[0;1],'Covariance',[1,0;0,1]);  % Distribution for state = 1
g2 = GaussD('Mean',[0;-1],'Covariance',[1,0;0,1]); % Distribution for state = 2
h  = HMM(mc, [g1; g2]);                            % The HMM
[X_GaussD,S_GaussD] = rand(h, 100);                % Generate an output sequence

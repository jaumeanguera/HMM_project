
clc;
close all;

% A.1 HMM Signal Source
% Define simple infinite-duration HMM
p_initial = [0.5;0.5];                  % Initial probability
A_initial = [0.9 0.1;0.05 0.95];        % Transition probability
mc = MarkovChain(p_initial, A_initial); % State generator
g1 = GaussD('Mean',0,'StDev',1);        % Distribution for state = 1
g2 = GaussD('Mean',2,'StDev',3);        % Distribution for state = 2
h  = HMM(mc, [g1; g2]);                 % The HMM
x = rand(h, 100);                       % Generate an output sequence

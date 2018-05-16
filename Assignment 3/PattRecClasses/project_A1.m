
clc;
close all;

% First assignment Pattern Recognition and Machine Learning Project
% Authors: Ashutosh Vaishnav and Jaume Anguera Peris
% A.1 HMM Signal Source


%% ---------------- A.1.1 HMM Random Source ----------------
% General parameters for INFINTE Markov Chain
p_initial = [0.5; 0.5];                   % Initial probability
A_initial = [0.8 0.2; 0.05 0.95];         % Transition probability
mc = MarkovChain(p_initial, A_initial);   % State generator

% Define HMM with Discrete output
g1 = DiscreteD([1;0]);                    % Distribution for state = 1
g2 = DiscreteD([0;1]);                    % Distribution for state = 2
h  = HMM(mc, [g1; g2]);                   % The HMM
[X_DiscreteD,S_DiscreteD] = rand(h, 100); % Generate an output sequence



%% ------------ A.1.2 Verify the MarkovChain and HMM Sources ------------
% INFINITE Markov Chain with Gaussian output
p_initial = [0.75; 0.25];                 % Initial probability
A_initial = [0.99 0.01; 0.03 0.97];       % Transition probability
mc = MarkovChain(p_initial, A_initial);   % State generator
g1 = GaussD('Mean',0,'StDev',1);          % Distribution for state = 1
g2 = GaussD('Mean',3,'StDev',2);          % Distribution for state = 2
h  = HMM(mc, [g1; g2]);                   % The HMM

% 1. Calculate P (S_t = j) for all time t
% P (S_(t+1) = j) = sum_k { A(k,j) * P (S_t = k) }
q = A_initial'*p_initial;


% 2. Calculate the relative frequency of occurrences of St = 1 and St = 2.
T = 10000;          % Length Markov Chain
S_t = mc.rand(T);   % Generate a sequence of T state integer numbers

fprintf('Results for question 2 in A.1.2:\n');
tabulate(S_t);      % Calculate and show relative frequency


% 3. Verify HMM rand method
X_test = h.rand(T);     % Generate output sequence for Gaussian dist
E_Xt = mean(X_test);    % Expectation output sequence
VAR_Xt = var(X_test);   % Variance output sequence

fprintf('\nResults for question 3 in A.1.2:\n');
fprintf('Expectation of the observable outputs E_Xt = %.3f\n',E_Xt);
fprintf('Variance of the observable outputs VAR_Xt = %.3f\n',VAR_Xt);


% 4. Get an impression of how the HMM behaves
T = 500;                % Length Markov Chain
X_test = h.rand(T);     % Generate ouput sequence

figure('Name','Gaussian output of HMM with different mu1 and mu2');
plot(X_test);
grid on; grid minor;
title('Behaviour of the HMM with different mu1 and mu2');
ylabel('Observable outputs as a function of time X_t');
xlabel('Time t');
ylim([-6 12]);


% 5. HMM identical to the previous one except that mu2 = mu1 = 0
g1 = GaussD('Mean',0,'StDev',1);          % Distribution for state = 1
g2 = GaussD('Mean',0,'StDev',2);          % Distribution for state = 2
h_q5  = HMM(mc, [g1; g2]);                % The HMM for question 5

T = 500;                % Length HMM
X_test = h_q5.rand(T);  % Generate ouput sequence considering mu2 = mu1 = 0

figure('Name','Gaussian output of HMM with same mu1 and mu2');
plot(X_test);
grid on; grid minor;
title('Behaviour of the HMM with same mu1 and mu2');
ylabel('Observable outputs as a function of time X_t');
xlabel('Time t');
ylim([-6 12]);


% 6. Check is the rand-function for finite-duration HMMs
% General parameters for FINITE Markov Chain
p_initial = [0.5; 0.5];                   % Initial probability
A_initial = [0.8 0.1 0.1; 0.05 0.85 0.1]; % Transition probability
mc = MarkovChain(p_initial, A_initial);   % State generator

% Define HMM with Gaussian output
g1 = GaussD('Mean',0,'StDev',1);              % Distribution for state = 1
g2 = GaussD('Mean',3,'StDev',2);              % Distribution for state = 2
h_q6  = HMM(mc, [g1; g2]);                    % The HMM for question 6
[X_GaussFinite,S_GaussFinite] = h_q6.rand(T); % Output sequence


% 7. Rand-functions for estate-conditional output distributions
% Define HMM with Gaussian output
g1 = GaussD('Mean',[1;1],'Covariance',eye(2));      % Distribution for state = 1
g2 = GaussD('Mean',[-1;-1],'Covariance',[2 1;1 4]); % Distribution for state = 2
h_q7  = HMM(mc, [g1; g2]);                          % The HMM for question 7
[X_GaussD,S_GaussD] = h_q7.rand(T);                 % Output sequence


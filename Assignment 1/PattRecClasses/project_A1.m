
clc;
close all;

%% A.1.1 HMM Signal Source
% Define simple infinite-duration HMM
p_initial = [0.5;0.5];                  % Initial probability
A_initial = [0.8 0.1;0.05 0.9];        % Transition probability
mc = MarkovChain(p_initial, A_initial); % State generator
g1 = GaussD('Mean',[1;1],'Covariance',[1,0;0,1]);        % Distribution for state = 1
g2 = GaussD('Mean',[-1;-1],'Covariance',[1,0;0,1]);        % Distribution for state = 2
h  = HMM(mc, [g1; g2]);                 % The HMM
x = rand(h, 100);                       % Generate an output sequence
%% A.1.2 Testing the Markov model given in the question
A = [0.99 0.01;0.03 0.97];
q = [0.75;0.25];
b1 = GaussD('Mean',0,'StDev',1);        % Distribution for state = 1
b2 = GaussD('Mean',0,'StDev',2);        % Distribution for state = 2

mc = MarkovChain(q,A);
StateSeq = mc.rand(10000);
table = tabulate(StateSeq);
fprintf("The relative frequency in state sequence is %0.2f and %0.2f \n", table(1,3)/100, table(2,3)/100)

h = HMM(mc, [b1;b2]);
X = h.rand(10000);
mean(X), var(X)
%% Visualizing behaviour of HMM
Xplot = h.rand(500);
figure('Name','Gaussian output of HMM with different mu1 and mu2');
plot(Xplot);
grid on; grid minor;
title('Behaviour of the HMM with same mu1 and mu2');
ylabel('Observable outputs X_t');
xlabel('Time t');
ylim([-6 12]);

%% Finite duration HMM
p_initial = [0.5;0.5];                  % Initial probability
A_initial = [0.8 0.1 0.1;0.05 0.9 0.05];        % Transition probability
mc = MarkovChain(p_initial, A_initial); % State generator
g1 = GaussD('Mean',0,'StDev',1);        % Distribution for state = 1
g2 = GaussD('Mean',3,'StDev',2);        % Distribution for state = 2
h  = HMM(mc, [g1; g2]);                 % The HMM
x = rand(h, 100);                       % Generate an output sequence
plot(x)
%% HMM that generates vector output and is finite
p_initial = [0.5;0.5];                  % Initial probability
A_initial = [0.8 0.1 0.1;0.05 0.9 0.05];        % Transition probability
mc = MarkovChain(p_initial, A_initial); % State generator
g1 = GaussD('Mean',[1;1],'Covariance',[1,0;0,1]);        % Distribution for state = 1
g2 = GaussD('Mean',[-1;-1],'Covariance',[2,1;1,4]);        % Distribution for state = 2
h  = HMM(mc, [g1; g2]);                 % The HMM
x = rand(h, 100);                       % Generate an output sequence
figure('Name','Gaussian output of HMM with different mu1 and mu2');
plot(x(1,:));
hold on
plot(x(2,:));
grid on; grid minor;
title('Output samples from HMM with Gaussian vector distributions');
ylabel('Observable outputs (X_t)');
xlabel('Time(t)');
ylim([-6 6]);
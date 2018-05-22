%% Testing forward Algo
p_initial = [1;0];                      % Initial probability
A_initial = [0.9 0.1 0;0 0.9 0.1];      % Transition probability
mc = MarkovChain(p_initial, A_initial); % State generator
g1 = GaussD('Mean',0,'StDev',1);        % Distribution for state = 1
g2 = GaussD('Mean',3,'StDev',2);        % Distribution for state = 2
h  = HMM(mc, [g1; g2]);                 % The HMM

X = [-0.2,2.6,1.3];

% [pX(1,:),temp] = h.OutputDistr(1).prob(X);
% [pX(2,:),temp] = h.OutputDistr(2).prob(X);
pX = h.OutputDistr.prob(X);
% pX = zeros(size(A_initial,1),size(X,1));
% Mu = [0;3];
% Sigma = [1,2];
% for i=1:3
%     for j=1:2      
%         mu = Mu(j);
%         sigma = Sigma(j);
%         x = X(i);
%         pX(j,i) = exp(-(x-mu)^2/sigma^2/2)/(sigma*sqrt(2*pi));
%     end
% end
[alfaHat, c] = h.StateGen.forward(pX);

%% Testing logprob function

Prob = h.logprob(X);

%% Testing backward algo
bataHat = h.StateGen.backward(pX,[1;0.1625;0.8266;0.0581])
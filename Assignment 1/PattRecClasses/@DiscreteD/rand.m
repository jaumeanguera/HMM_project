function R = rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors: Ashutosh Vaishnav and Jaume Anguera Peris 
%----------------------------------------------------

if numel(pD)>1
    error('Method works only for a single DiscreteD object');
end;

%*** Insert your own code here and remove the following error message 

% Generate a random sequence of integers where each element of the sequence
% can take any value 'n' from 1 to N with Prob(n) defined in pD.ProbMass.
N = length(pD.ProbMass);
R = randsrc(nData,1,[1:N;pD.ProbMass']);

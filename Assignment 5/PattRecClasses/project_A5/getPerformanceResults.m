function accuracy = getPerformanceResults(probObsData,classes) 
% GETPERFORMACERESULTS calculates the accuracy of the classifications as
% the fraction between the number of correctly classified audios divided by
% the total number of audios. This process is repeated for each class, so
% the output is a vector where each element is the accuracy percentage for
% each class

nClasses = length(classes);
accuracy = zeros(1,nClasses);

for k = 1:nClasses
    % Get matrix of P(X = class | HMM(k) )
    Prob = probObsData{k};
    
    % Get class that satisfy i = argmin P(X = class(i) |?HMM(k) )
    [~,ind] = max(Prob,[],2);
    
    % Calculate percentage of accuracy
    accuracy(k) = sum(ind == k)/size(Prob,1);
end


end


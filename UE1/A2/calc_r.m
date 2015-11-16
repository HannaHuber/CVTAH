function [ r ] = calc_r(Xn, my_k)
%CALC_R Assigns data points to clusters
%   Input:  Xn   ...    DxN Matrix of N D-dimensional datapoints
%                       3D : color values only
%                       5D : color and position values
%           my_k ...    clusters
%   Output: 
%   r            ...    NxK matrix assigning each datapoint a particular
%                       cluster:
%                       r(n,k) = 1 if Xn belongs to cluster k
%                       r(n,k) = 0 otherwise 
%% Size of dimension - 3D or 5D
dimension = size(Xn, 1);
K = size(my_k,2);
N = size(Xn, 2);
% Initialize r
r = zeros(K,N);
%% Iteration over all datapoints
for i = 1:size(Xn, 2)
    
    % Get actual value
    x = Xn(:,i);

    % Duplicate x
    duplicateX = repelem(x,1,K);
    
    % Substract x from clusters
    diff = my_k - duplicateX;
    diff = abs(diff);
    
    % Sum up differences
    sumDiff = sum(diff);
    
    % Get the smallest difference
    minimum = min(sumDiff);
    
    % Get the index of the smallest difference
    index = find(sumDiff == minimum);
    
    % Put 1 to cell of cluster of the smallest difference 
    r(index,i) = 1;
end
end


function [ J ] = calc_j( xn, mk, r  )
%CALC_J objective function for the k-means clustering algorithm
%   Computes the sum of the squares of the distances of each data point to its assigned
%   cluster centroid
%   Input:  xn  ...     DxN Matrix of D-dimensional datapoints
%           mk  ...     DxK Matrix cluster centroids
%           r   ...     NxK Matrix assigning each datapoint a particular
%                       cluster:
%                       r(n,k) = 1 if xn belongs to cluster k
%                       r(n,k) = 0 otherwise
%   Output: J   ...     scalar representing the measure of distortion

% Number of data points
N = size(xn, 2);

% Init sum
J = 0;

% Iterate over all data points
for n = 1:N
    J = J + norm(xn(:,n)- mk*(r(n,:))');
end

end


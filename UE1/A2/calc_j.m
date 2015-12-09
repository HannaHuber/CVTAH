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

% Squared distances between data points and centroids
squared_distances = sum((xn - mk*r).^2, 1);
% Sum over all data points
J = sum(squared_distances);

end


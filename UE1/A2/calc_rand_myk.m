function [ my_k ] = calc_rand_myk(d, k )
%CALC_RAND_MYK Chooses initial cluster centroids randomly
%   Input:  d   ...     dimensions
%           k   ...     number of clusters
%   Output: 
%   my_k        ...     clusters with randomly initialized values between 0
%                       and 1
%% Random values between 0 and 1
my_k = rand(d,k);
end


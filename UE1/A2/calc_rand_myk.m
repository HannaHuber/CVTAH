function [ my_k ] = calc_rand_myk(d, k )
%CALC_RAND_MYK Chooses initial cluster centroids randomly
%   Input:  d   ...     dimensions
%           k   ...     number of clusters
%   Output: 
%   my_k        ...     clusters with randomly initialized values between 0
%                       and 1
%% Iterate over whole matrix
my_k = zeros(d,k);
for i = 1:k
    for j = 1:d
        % Choose a random number between 0 and 1
        my_k(j,i) = rand(1);
    end
end
end


function [ filter ] = calc_LoG( sigma )
%CALC_LOG Calculates the Laplacian of Gaussian (LoG) filter using a
%specified standard deviation
% Input:
%   sigma       ... standard deviation of current scale
% Output:
%   LoG_filter  ... scale normalized LoG filter

%% Build a scale-normalized Laplacian of Gaussian filter with current scale.
% count filter size
size = 2 * floor(3 * sigma) + 1;
filterSize = [size size];

% Create filter
filter = fspecial('log', filterSize, sigma);

% Scale-normalizing the filter
filter =  sigma^2 * filter;

%% Hint (see assignment)
% Filter creation: use the fspecial function with parameter 'log' to create the LoG
% filters. Since the response of LoG decreases as  increases, you have to scale-normalize
% the filter by multiplying it with 2. In order to decrease computation time for smaller ,
% you should set the filter size proportional to . A good choice is to restrict the filter size
% to the range [-3sigma; 3sigma], i.e. the filter size is computed as 2|_3sigma_| + 1. 
% Note: |_ and _| = Gaussklammer --> abrunden!
end


function [ filter ] = calc_LoG( sigma )
%CALC_LOG Calculates the Laplacian of Gaussian (LoG) filter using a
%specified standard deviation
% Input:
%   sigma       ... standard deviation of current scale
% Output:
%   LoG_filter  ... scale normalized LoG filter

%% Build a scale-normalized Laplacian of Gaussian filter with current scale.
% count filter size
% A good choice is to restrict the filter size
% to the range [-3sigma my; 3sigma my], i.e. the filter size is computed as 2|_3 my sigma_| + 1. 
size = 2 * floor(3 * sigma) + 1;
filterSize = [size size];

% Create filter
filter = fspecial('log', filterSize, sigma);

% Scale-normalizing the filter
% Since the response of LoG decreases as my increases, you have to scale-normalize
% the filter by multiplying it with my^2.
filter =  sigma^2 * filter;

%% Hint (see assignment)
% Filter creation: use the fspecial function with parameter 'log' to create the LoG
% filters. Since the response of LoG decreases as my increases, you have to scale-normalize
% the filter by multiplying it with my^2. In order to decrease computation time for smaller my,
% you should set the filter size proportional to my. A good choice is to restrict the filter size
% to the range [-3sigma my; 3sigma my], i.e. the filter size is computed as 2|_3 my sigma_| + 1. 
% Note: |_ and _| = Gaussklammer --> abrunden!
end


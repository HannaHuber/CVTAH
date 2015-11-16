function [ scale_response ] = calc_response( img, LoG_filter )
%CALC_RESPONSE Calculates the absoule Laplacian of Gaussion (LoG) response
%for a specific scale space level
% Input:
%   img             ... HxW matrix of original image
%   LoG_filter      ... scale-normalized LoG filter for a specific scale
% Output:
%   scale_response  ... HxW matrix of convolved image

%% TODO (see assignment)
% Convolve the image with the filter and save the absolute response of LoG for the
% current level of scale space.

%% Hint (see assignment)
% Convolution: for scale space creation, in the convolution step you should avoid (a) different
% dimensions of the output images due to different filter sizes and (b) artefacts at
% the image borders, i.e. high responses caused by unreasonable assumptions for values
% outside the image. The best way to achieve this is to use the imfilter function with parameters
% 'same' and 'replicate' for convolution. You can read up the effects of these
% parameters in the function reference.


end


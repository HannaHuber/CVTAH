function [ blob_centers, blob_levels ] = detect_blobs( scale_space )
%DETECT_BLOBS Detects blobs in the 3D scale space by performing non-maximum
%suppression
% Input:
%   scale_space         ... HxWxL matrix representing the scale space (=absolute
%                           response to a scale-normalized LoG filter) of a HxW 
%                           image with L scale levels
% Output:
%   blob_centers        ... Nx2 matrix of N detected blob coords, where 
%                           blob_centers(i,:)=(xi,yi) are the pixel coordinates of the ith blob
%   blob_levels         ... Nx1 vector containing the scale space level
%                           where the corresponding blob was detected

%% TODO (see assignment)

% Perform non-maximum suppression in the 3D scale space: a point is detected at position
% (x; y) with scale i if the point is above a certain fixed threshold and a local maximum
% when compared to its 8 neighboring points at scale i as well as to its 9 neighboring
% points at scales i?1 and i+1, respectively.

%% Hint (see assignment)
% Non-maximum suppression: The LoG filter produces positive as well as negative responses
% and thus for extrema detection one has to search for local minima in the negative
% domain as well as for local maxima in the positive domain. However, as local minima
% and maxima are treated likewise, it is more convenient to take the absolute responses and
% search for local maxima only.

end


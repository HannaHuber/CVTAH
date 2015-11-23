function [ localMaxima ] = detect_blobs( scale_space )
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

threshold = 30;
[h,w,levels] = size(scale_space);

%# s = 3D array
msk = ones(3,3,3);
msk(2,2,2) = 0;
%# assign, to every voxel, the maximum of its neighbors
s_dil = imdilate(scale_space,msk);
M1 = (scale_space > s_dil); %# M is 1 wherever a voxel's value is greater than its neighbors
M2 = (scale_space > threshold);

M = M1 & M2;

%set first and last row and column to zero (Randbehandlung)
% M(1,:,:) = 0;
% M(h,:,:) = 0;
% M(:,1,:) = 0;
% M(:,w,:) = 0;

localMaxima = [0,0,0];

%[x,y,levels] = ind2sub(size(M),find(M));
%localMaxima = [x,y,levels];
for blob_level = 2:levels-1
   [blob_centers_x,blob_centers_y] = find(M(:,:,blob_level));
   maximaSize = size(blob_centers_x, 1);
   localMaxima = [localMaxima;[blob_centers_x, blob_centers_y, repmat(blob_level, maximaSize,1)]];
end

localMaxima = localMaxima(2:end,:);

end


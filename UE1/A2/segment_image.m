function [ I_clustered ] = segment_image( h, w, xn, r )
%SEGMENT_IMAGES Segments image into clusters
%   Image regions are colored with mean color values of all image points
%   assigned to that cluster
%   Input:  h   ...     original image height
%           w   ...     original image width
%           xn  ...     DxN Matrix of N D-dimensional datapoints
%                       3D : color values only
%                       5D : color and position values
%           r   ...     NxK matrix assigning each datapoint a particular
%                       cluster:
%                       r(n,k) = 1 if xn belongs to cluster k
%                       r(n,k) = 0 otherwise 
%   Output: 
%   I_clustered ...     segemnted image with colorized clusters; 
%                       a cluster's color is the mean color value of all pixels belonging to that cluster
%% Initialize
% Vector of (segmented) image points
yn = zeros(3, size(xn,1));
% Number of clusters
K = size(r,2);
% Get corresponding clusters
[i,~] = find(r);
%% Iterate over all clusters
for k = 1:K
    % Data points belonging to cluster k
    points = find(i==k);
    cluster = xn(1:3,points);
    % Mean color value
    mean_color = mean(cluster,2);
    % Colorize cluster points 
    yn(1:3,points) = repmat(mean_color,1,length(points));
end
%% Create clustered image
I_clustered = cat(3,reshape(yn(1,:),h,w),reshape(yn(2,:),h,w),reshape(yn(3,:),h,w));
end


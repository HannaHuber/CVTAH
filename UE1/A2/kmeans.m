function [ I_segmented ] = kmeans( I, D, k, t )
%KMEANS Performs image segmentation using the k-means algorithm
%   Input:  I           ...     original image
%           D           ...     data point dimension:
%                               3D : color values only
%                               5D : color and position values
%           k           ...     number of clusters
%           t           ...     threshold for distortion measure
%   Output: I_segmented ...     image containing image regions 
%                               corresponding to clusters; 
%                               image regions are coloured with the 
%                               respective cluster's mean color value

%% Read images
%% Create data points
%% K-Means iteration
J_ratio = Inf(1);
J_old = Inf(1);
while (J_ratio > t)
    % Random starting values for cluster centroids
    % Assign data points to nearest cluster centroid
    % Recalculate cluster centroids
    % Calculate distortion measure
    J_new = distortionMeasure(xn, mk, r);
    J_ratio = J_old/J_new;
    J_old = J_new;    
end
%% Image segmentation

end


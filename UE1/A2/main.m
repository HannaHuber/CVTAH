%% Assignment I/2: Image Segmentation by K-means Clustering
% Authors: Tomas Musil, Andreas Wittmann, Hanna Huber

function [] = main(img_path, d3_or_d5, k, cluster_treshold)
% Input: 
%   img_path            ... path to image (which should be clustered)
%   3D_or_5D            ... '3D' if it should only use color information for
%                           clustering, '5D' if it should use color and spatial information for
%                           clustering
%   k                   ... number of clusters
%   cluster_treshold    ... if the J ratio reaches a given threshold, terminate the clustering
%
% Output (saved): 
%   clustered           ... clustered image with colorized cluster
%                           pixels (mean color values of cluster pixels)
%% Read images
% TODO
%% Calculate data points
Xn = calc_Xn(img_path, d3_or_d5);
%% K-Means iteration
% init J
J = Inf(1);
J_ratio = Inf(1);
my_k = calc_rand_myk(size(Xn, 1));
% iterate until treshold is reached
while(J_ratio > cluster_treshold)
    % assign data points to clusters
    r = calc_r(Xn, my_k);
    % recalculate cluster centroids
    my_k = calc_cluster_centroids(r, Xn);
    % calculate distortion measure
    J_new = calc_j(Xn, r, my_k);
    J_ratio = J/J_new;
    J = J_new;
end
%% Image segmentation
%TODO
end
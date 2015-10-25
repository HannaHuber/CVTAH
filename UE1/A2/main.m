%% Assignment I/2: Image Segmentation by K-means Clustering
% Authors: Tomas Musil, Andreas Wittmann, Hanna Huber

function [] = main(img_path, d3_or_d5, cluster_treshold)
% Input: 
%   img_path  ... path to image (which should be clustered)
%   3D_or_5D  ... '3D' if it should only use color information for
%   clustering, '5D' if it should use color and spatial information for
%   clustering
%   cluster_treshold ...if the J ratio lies under a given threshold, terminate the clustering
%
% Output: (saved): clustered ...clustered image with colorized cluster
% pixels (mean color values of cluster pixels)

Xn = calc_Xn(img_path, d3_or_d5);

%init J
J = -1; %TODO sinnvollen Wert initialisieren
J_ratio = -1; %TODO sinnvollen Wert initialisieren
my_k = calc_rand_myk(size(Xn, 1));

while(J_ratio < cluster_treshold)
    r = calc_r(Xn, my_k);
    my_k = calc_cluster_centroids(r, Xn);
    J_new = calc_j(Xn, r, my_k);
    
    J_ratio = abs(J_new-J);
    J = J_new;
end

%image segmentation
%TODO
end
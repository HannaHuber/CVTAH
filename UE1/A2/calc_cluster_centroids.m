function [ my_k ] = calc_cluster_centroids(r, Xn, my_k)
%CALC_CLUSTER_CENTROIDS Recalculates cluster centroids
%   Input:  r    ...    NxK matrix assigning each datapoint a particular
%                       cluster:
%                       r(n,k) = 1 if Xn belongs to cluster k
%                       r(n,k) = 0 otherwise 
%           Xn   ...    DxN Matrix of N D-dimensional datapoints
%                       3D : color values only
%                       5D : color and position values
%           my_k ...    number of clusters
%   Output: 
%   my_k         ...    clusters with updated values

%% Dimension - 3D or 5D
dimension = size(Xn, 1);
%% Initilize new_k with zeros
new_k = zeros([size(Xn, 1)+1, size(r, 1)]);
%% Iterate over all datapoints
for i = 1:size(Xn, 2)
    
    % Iterate over all clusters
    for j = 1:size(r, 1)
        
        % Update only corresponding cluster values of dataset
        if(r(j,i) == 1)
           
            % Iterate over all dimension
            for d = 1:dimension
                new_k(d,j) = new_k(d,j) + Xn(d,i);
            end
            % Update number of datasets coresponding to actual cluster
            new_k(d+1,j) = new_k(d+1,j) + 1;
        end
    end
end

%% Iterate over all clusters and calculate mean
 for j = 1:size(r, 1)
    if(new_k(dimension+1,j) ~= 0)
        % Iterate over all dimension
        for d = 1:dimension
            my_k(d,j) = new_k(d,j) / new_k(dimension+1,j);
        end
    end
end
end


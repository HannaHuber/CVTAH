function [ r ] = calc_r(Xn, my_k)
%CALC_R Assigns data points to clusters
%   Input:  Xn   ...    DxN Matrix of N D-dimensional datapoints
%                       3D : color values only
%                       5D : color and position values
%           my_k ...    clusters
%   Output: 
%   r            ...    NxK matrix assigning each datapoint a particular
%                       cluster:
%                       r(n,k) = 1 if Xn belongs to cluster k
%                       r(n,k) = 0 otherwise 
%% Size of dimension - 3D or 5D
dimension = size(Xn, 1);
K = size(my_k,2);
N = size(Xn, 2);
% Initialize r
r = zeros(K,N);
%% Iteration over all datapoints
for i = 1:size(Xn, 2)
    
    x = Xn(:,i);
    %duplicateX = repmat(x,[1 K]);
    duplicateX = repelem(x,1,K);
    
    diff = my_k - duplicateX;
    diff = abs(diff);
    
    sumDiff = sum(diff);
    
    minimum = min(sumDiff);
    
    index = find(sumDiff == minimum);
    
    r(index,i) = 1;
    


%     % Save the smallest distance to cluster and the number of cluster
%     smallest_distance_to_cluster = Inf(1);
%     smallest_distance = Inf(1);
%     
%     % Iteration over all cluster
%     for j = 1:size(my_k, 2)
%         actual_distance = 0;
%         % Iteration over all dimensions and count distance
%         for d = 1:dimension
%             actual_distance = actual_distance + ((Xn(d,i) - my_k(d,j))^2);
%         end
%         
%         % If distance of actual cluster is smaller, update the smallest
%         % distance and the cluster number
%         if(actual_distance < smallest_distance)
%             smallest_distance = actual_distance;
%             smallest_distance_to_cluster = j;
%         end
%     end
%     
%     % Create r matrix. The smallest cluster gets value 1 and all other 0
%     for j = 1:size(my_k, 2)
%         if(smallest_distance_to_cluster == j)
%             r(j,i) = 1;
%         else
%             r(j,i) = 0;
%         end
%     end
end
end


function [h,w] = calcRange(img, H_rel)

%% Init cell of transformed corners
tcorners = zeros(2,4,5);
%% Calculate transformed corners
% Reference image: corners = tranformed corners
tcorners(:,:,3) = [ [1;1] [size(img{3},1);1] [size(img{3},1);size(img{3},2)] [1;size(img{3},2)] ];
% Other images
for i = [1,2,4,5]
    % Current corner coords
    corners = [ [1;1] [size(img{i},1);1] [size(img{i},1);size(img{i},2)] [1;size(img{i},2)] ];
    % Transformed corner coords (relative to reference)
    tcorners(:,:,i) = H_rel{i} * corners;    
end
% Minimal coords
xy_min = min(min(tcorners,[],2),[],3);
% Maximal coords
xy_max = max(max(tcorners,[],2),[],3);
% Calculate range between minima and maxima
range = xy_max - xy_min;
% Get image dimensions from range vector
h = range(1);
w = range(2);
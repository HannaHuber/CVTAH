function [h,w] = calcRange(img, H_rel)

%% Init cell of transformed corners
n = size(img,2);
tcorners = zeros(4,2,n);
%% Calculate transformed corners
for i = 1:n
    % Current corner coords (x=columns, y=rows)
    % Each row in the corner matrix corresponds to the homogeneous coords
    % of one corner: [x y 1]
    corners = [ [1 1 1]; [size(img{i},2) 1 1]; [size(img{i},2) size(img{i},1) 1]; [1 size(img{i},1) 1] ];
    % Transformed corner coords (relative to reference)
    % [u v 1] = [x y 1] * H
    tcorners_3d = corners * H_rel{i};
    % Divide by 3rd coord
    tcorners(:,:,i) = tcorners_3d(:,1:2)./repmat(tcorners_3d(:,3),1,2);    
end
% Minimal coords
xy_min = min(min(tcorners,[],1),[],3);
% Maximal coords
xy_max = max(max(tcorners,[],1),[],3);
% Calculate range between minima and maxima
w = [xy_min(1) xy_max(1)];
h = [xy_min(2) xy_max(2)];
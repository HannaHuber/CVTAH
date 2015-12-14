%% Assignment 4: Image Stitching

function [mosaic] = stitchImages(impath)
% impath... array of images paths
%% Init
img = cell(1,5); 
%the SIFT keypoints of the image I.
%   [X;Y;S;TH], where X,Y is the (fractional) center of the frame,
%   S is the scale and TH is the orientation (in radians).
F = cell(1,5); 
D = cell(1,5); %is the descriptor of the corresponding keypoint in F. (128dim vector)

for i = 1:5
    %% Read and convert image
    img{i} = imread(char(impath(i)));
    img_gray = rgb2gray(img{i});
    img_single = im2single(img_gray);

    %% Create SIFT descriptors 
    % D...128xN matrix for N keypoints
    [F{i},D{i}] = vl_sift(img_single);
    F{i}(:) = round(F{i}(:));
end

matching_indices = cell(1,4);
% for each pair img(i),img(i+1) matching_indices(i) is a Nx2 matrix for N
% matches
for p=1:4
    %% Match keypoints for neighboring images (A)
    [matches] = vl_ubcmatch(D{p},D{p+1});
    % TODO find corresponding indices: 
    % matching_indices{p}=
    % TODO plot matches
    points_p1 = F{p}(1:2,matches(1,:))';
    points_p2 = F{p+1}(1:2,matches(2,:))';
    
    match_plot(img{p}, img{p+1}, points_p1, points_p2);
    %% Calculate homography for neighboring images (A)
    H = cell(1,4);
    H{p} = calcHomography(F{p}, F{p+1}, matching_indices);
end
%% Calculate transformations relative to reference image (=img3)(H)
H_rel = calcRelativeTransformation(H);

%% Calculate mosaic size (H)
[h, w] = calcRange(img, H_rel);

%% Transform images (H)
img_transformed = cell(1,5);
for i=1:5
    img_transformed{i} = imtransform(img{i},H_rel{i},'XData',[1 h], 'YData',[1 w]);
end
%% Blend images (T)
% TODO C.5
mosaic = blendImages(img_transformed{1},img_transformed{2},img_transformed{3},img_transformed{4},img_transformed{5});








end
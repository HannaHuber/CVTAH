%% Assignment 4: Image Stitching

function [mosaic] = stitchImages(impath)
% impath... array of images paths
%% Init
img_rgba = cell(1,5); 
% SIFT keypoints of the image I. 
%   [X;Y;S;TH], where X,Y is the (fractional) center of the frame,
%   S is the scale and TH is the orientation (in radians).
F = cell(1,5); 
% SIFT descriptor of the corresponding keypoint in F. (128dim vector)
D = cell(1,5); 
%% Iterate over all images
for i = 1:5
    %% Read and convert image
    img = imread(char(impath(i)));
    img_gray = rgb2gray(img);
    img_single = im2single(img_gray);
    %% Add alpha channel
    alpha_channel = calcAlpha(size(img,1), size(img,2));
    img_rgba{i} = cat(3,img,alpha_channel);
    
    %% Create SIFT descriptors 
    % D...128xN matrix for N keypoints
    [F{i},D{i}] = vl_sift(img_single);
    % F{i}(:) = round(F{i}(:));
end

matching_indices = cell(1,4);
H = cell(1,4);
I = cell(1,4);
% for each pair img(i),img(i+1) matching_indices(i) is a Nx2 matrix for N
% matches
for p=1:4
    %% Match keypoints for neighboring images (A)
    [matches] = vl_ubcmatch(D{p},D{p+1});
    % get coords of matched keypoints
    points_p1 = F{p}(1:2,matches(1,:))';
    points_p2 = F{p+1}(1:2,matches(2,:))';
    % plot matches
    %match_plot(img{p}, img{p+1}, points_p1, points_p2);
    %% Calculate homography for neighboring images (A)    
    [H{p}, ~] = calcHomography(F{p}, F{p+1}, matches);
end
%% Calculate transformations relative to reference image (=img3)(H)
H_rel = calcRelativeTransformation(H);

%% Calculate mosaic size (H)
[h, w] = calcRange(img_rgba, H_rel);

%% Transform images (H)
img_transformed = cell(1,5);
for i=1:5
    H=maketform('projective',H_rel{i});
    img_transformed{i} = imtransform(img_rgba{i},H,'XData',w, 'YData',h);
end
%% Blend images (T)
% TODO C.5
mosaic = blendImages(img_transformed{1},img_transformed{2},img_transformed{3},img_transformed{4},img_transformed{5});








end
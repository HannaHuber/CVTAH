%% Assignment 4: Image Stitching

function [mosaic] = stitchImages(impath, mosaicType)
% impath... array of images paths
%% Init
img_rgba = cell(1,5); 
% SIFT keypoints of the image I. 
%   [X;Y;S;TH], where X,Y is the (fractional) center of the frame,
%   S is the scale and TH is the orientation (in radians).
F = cell(1,5); 
% SIFT descriptor of the corresponding keypoint in F. (128dim vector)
D = cell(1,5); 
% Homographies
H = cell(1,4);
% Transformed images (in mosaic size)
img_transformed = cell(1,5);
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

%% Iterate over all image pairs
for p=1:4
    %% Match keypoints for neighboring images (A)
    [matches] = vl_ubcmatch(D{p},D{p+1});
    
    %% Calculate homography for neighboring images (A)    
    [H{p}, ~] = calcHomography(F{p}, F{p+1}, matches);
    
end
%% Calculate transformations relative to reference image (=img3)(H)
H_rel = calcRelativeTransformation(H);

%% Calculate mosaic size (H)
[h, w] = calcRange(img_rgba, H_rel);

%% Transform images (H)
for i=1:5
    H=maketform('projective',H_rel{i});
    img_transformed{i} = imtransform(img_rgba{i},H,'nearest','XData',w, 'YData',h);
end
%% Blend images (T)
mosaic = blendImages(img_transformed{1},img_transformed{2},img_transformed{3},img_transformed{4},img_transformed{5}, mosaicType);







end
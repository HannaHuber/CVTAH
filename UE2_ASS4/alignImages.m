%% Assignment 4.B: Interest Point Matching and Image Registration

function [ ] = alignImages( impath1, impath2 )
%REGISTERANDMATCHIMAGES aligns two overlapping images (4.B)
%   Input: impath1, impath2 ... paths to overlapping images
%% Read images
img1 = imread(impath1);
img2 = imread(impath2);
%% Get SIFT features
[F1, D1] = detectInterestPoints(impath1, false);
[F2, D2] = detectInterestPoints(impath2, false);

%% Match images and plot results
[matches] = vl_ubcmatch(D1,D2);
match_plot(img1, img2, F1(1:2,matches(1,:))', F2(1:2,matches(2,:))');

%% Calculate image transformation
H = calcHomography(F1, F2, matches);
% TODO: [H, I] = calcHomography(F1, F2, matches);
%       match_plot(img1, img2, F1(I)', F2(I)');

%% Transform first image
img1_transformed = imtransform(img1,H,'XData',[ 1 size(img2,2)], 'YData',[ 1 size(img2,1)]);

%% Calculate absolute differences
abs_diff = abs(img2 - img1_transformed);
figure('Name', 'B: Absolute differences');
imshow(abs_diff);
end


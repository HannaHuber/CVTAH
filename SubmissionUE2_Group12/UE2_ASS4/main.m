%% MAIN UE2 - Ass 4
close all;

%% Init
impath = cell(5,1);
impath(1) = cellstr('ass4_data/campus1.jpg');
impath(2) = cellstr('ass4_data/campus2.jpg');
impath(3) = cellstr('ass4_data/campus3.jpg');
impath(4) = cellstr('ass4_data/campus4.jpg');
impath(5) = cellstr('ass4_data/campus5.jpg');

%% A - SIFT Interest Point Detection
% detectInterestPoints(impath{4}, true);

%% B - Interest Point Matching and Image Registration
% Align two consecutive images
% alignImages(impath{1}, impath{2});
% Repeat with transformed second image
% alignImages(impath{1}, 'ass4_data/campus2_rot.jpg');

%% C - Image Stitching
% You can choose between feathering and no_feathering
mosaic = stitchImages(impath, 'feathering');
% Visualize stitched image
imshow(mosaic);




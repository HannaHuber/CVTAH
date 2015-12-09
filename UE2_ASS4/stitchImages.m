%% Assignment 4: Image Stitching

function [mosaic] = stitchImages(impath)
% impath... array of images paths
%% Init
img = cell(1,5); 
img_gray = cell(1,5);
img_single = cell(1,5);
F = cell(1,5);
D = cell(1,5);

for i = 1:5
    %% Read and convert image
    img{i} = imread(impath(i));
    img_gray{i} = rgb2gray(img{i});
    img_single = im2single(img_gray{i});

    %% Create SIFT descriptors 
    % D...128xN matrix for N keypoints
    [F{i},D{i}] = vl_sift(img_single);

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
    %% Calculate homography for neighboring images (A)
    H = cell{1,4};
    H{p} = calcHomography(F{p}, F{p+1}, matching_indices);
end
%% Calculate transformations to reference image (H)
% reference image = img3
Href = cell(1,4);
Href{1} = H{2}.tdata.Tv* H{1}.tdata.T;
Href{2} = H{2}.tdata.T;
Href{3} = H{3}.tdata.Tinv;
Href{4} = H{3}.tdata.Tinv * H{4}.tdata.Tinv;
%% Calculate mosaic size (H)
% TODO C.3

%% Transform images (H)
img_transformed = transformImages(Href, img);
%% Blend images (T)
% TODO C.5
mosaic = blendImages(img_transformed{1},img_transformed{2},img_transformed{3},img_transformed{4},img_transformed{5}, mosaic_size);








end
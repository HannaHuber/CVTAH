%% Assignment 4: Image Stitching

function [mosaic] = stitchImages(impath)
% impath... array of images paths
%% Init
img = cell(1,5); 
F = cell(1,5);
D = cell(1,5);

for i = 1:5
    %% Read and convert image
    img{i} = imread(impath(i));
    img_gray = rgb2gray(img{i});
    img_single = im2single(img_gray);

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
Href = cell(1,5);
Href{1} = maketform('composite',H{2}.tdata.Tv, H{1}.tdata.T);
Href{2} = H{2};
Href{3} = maketform('projective',eye(2));
Href{4} = fliptform(H{3});
Href{5} = maketform('composite',H{3}.tdata.Tinv, H{4}.tdata.Tinv);
%% Calculate mosaic size (H)
% TODO C.3
tcorners = zeros(2,4,5);
tcorners(:,:,3) = [ [1;1] [size(img{3},1);1] [size(img{3},1);size(img{3},2)] [1;size(img{3},2)] ];
for i = [1,2,4,5]
    corners = [ [1;1] [size(img{i},1);1] [size(img{i},1);size(img{i},2)] [1;size(img{i},2)] ];
    tcorners(:,:,i) = Href{i}.data * corners;    
end
xy_min = min(min(tcorners,[],2),[],3);
xy_max = max(max(tcorners,[],2),[],3);

%% Transform images (H)
img_transformed = transformImages(Href, img, xy_min, xy_max);
%% Blend images (T)
% TODO C.5
mosaic = blendImages(img_transformed{1},img_transformed{2},img_transformed{3},img_transformed{4},img_transformed{5}, mosaic_size);








end
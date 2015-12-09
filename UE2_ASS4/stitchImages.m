%% Assignment 4: Image Stitching

function [mosaic] = stitchImages(impath1, impath2, impath3, impath4, impath5)

%% Read and convert images
impath = './ass4_data/campus1.jpg';
img = imread(impath);
img_bw = rgb2gray(img);
img_single = im2single(img_bw);
desc = vl_sift(img_single)



end
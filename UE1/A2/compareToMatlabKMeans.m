%% Compare kmeans to matlab version of kmeans
%% Read image data
img = imread(img_path);
[h,w,~] = size(img);
%% Calculate data points
Xn = calc_Xn(img, d3_or_d5);
%% 
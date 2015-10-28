%% test segmentation

%% Read images
img_path = 'C:/Users/Hanna/Documents/ComputerVision/CVTAH/UE1/A2/imgs/mm.jpg'; 
%img_path = 'C:/Users/Hanna/Documents/ComputerVision/CVTAH/UE1/A2/imgs/simple.png';
img = imread(img_path);
[h,w, ~] = size(img);
%% Calculate data points
d3_or_d5 = '3D';
Xn = calc_Xn(img, d3_or_d5)';
%% Arbitrary cluster assignment
r = zeros(w*h,3);
s1 = round(w*h/3);
s2 = round(2*w*h/3);
r(1:s1,1) = 1;
r(s1+1:s2,2) = 1;
r(s2+1:end,3) = 1;
%% Image segmentation
clustered = segment_image(h, w, Xn, r);
%% Show result
imshow(clustered);
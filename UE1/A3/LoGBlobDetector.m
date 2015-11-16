function [] = LoGBlobDetector( img_path, sigma0, k, levels)
%LOGBLOBDETECTOR Detects blobs in an image using scale invariant Laplacian
%                of Gaussian (LoG) filters
% Input:
%   impath         ... path to the grayscale (= 1 color channel) image file
%   sigma0         ... initial standard deviation of the LoG filter
%   k              ... standard deviation scale factor
%   levels         ... number of scale space levels
% Output (saved):
%   img_blobs ... image including detected blobs
%% Read image and map to range [0,1]
img = imread(img_path);
img = im2double(img);
%% Iterate over scale space levels
% Init scale space
[h,w] = size(img);
scale_space = zeros(h,w,levels);
sigma = sigma0;
for l = 1:levels
    % Create LoG filter for current scale
    log_filter = calc_LoG(sigma);
    % Saved absolute response (=convolved image) for current scale
    scale_space(:,:,l) = imfilter(img, log_filter, 'replicate', 'same');
    % Calculate sigma for next scale 
    sigma = sigma*k;
end
%% Detect blobs
[blob_centers, blob_levels] = detect_blobs(scale_space);
%% Calculate corresponding scale (sigma) from scale space level
% sigma_i = sigma0 * k^(l-1), i=1..levels
N = size(blob_centers, 1);
blob_scales = repmat(sigma0, N,1).*repmat(k,N,1).^(blob_levels-ones(N,1));
%% Mark blobs in image
% circle radius r = sigma * sqrt(2)
img_blobs = show_all_circles(img, blob_centers(:,1),blob_centers(:,2), blob_scales*sqrt(2));
%% Save image with detected blobs
name = strsplit(img_path, '.');
filename = strcat(name(1), '_blobs.jpg');
filename = strjoin(filename);
imwrite(img_blobs, filename);
%% Show result
imshow(img_blobs);
end


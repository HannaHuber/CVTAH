function [ img_blobs ] = mark_blobs( img, blob_centers, blob_scales)
%MARK_BLOBS Visualizes detected blobs in the corresponding image
% Input:
%   img                ... HxW matrix of original image
%   blob_centers       ... Nx2 matrix of N detected blob coords, where 
%                          blob_centers(i,:)=(xi,yi) 
%                          are the pixel coordinates of the ith blob
%   blob_scales        ... Nx1 vector of sigma values corresponding to the
%                          scale where the respective blob was detected:
%                          blob_scales(i) = sigma_i
% Output:
%   img_blobs          ... HxW matrix of image showing the detected blobs

%% TODO (see assignment)
% Visualization of results: You can use the function show_all_circles to visualize the
% detected blobs. The function takes the circle centers and corresponding radii and draws
% the circles in an image. However, to choose the correct radii, the relationship between the
% detected scale and the radius of the circle that most closely “approximates” the circle is
% needed. In other words, at what scale does the Laplacian achieve a maximum response
% to a binary circle of radius r? As illustrated in Fig. 5, for the maximum response the
% zeros of the LoG have to be aligned with the circle. As the LoG is given
% by (x^2 + y^2 - 2sigma^2)e^(-(x^2+y^2)/2sigma^2), the maximum response
% occurs at sigma = r/sqrt(2) (the proof is left as an
% exercise for interested students). As a consequence, you have to multiply the detected
% scale by sqrt(2) to get the correct radii of the circles to be drawn.



end


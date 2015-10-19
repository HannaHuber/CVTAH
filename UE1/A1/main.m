%% Assignment I/1: Colorizing Images
% Authors: Tomas Musil, Andreas Wittmann, Hanna Huber
function [] = main(img_r, img_g, img_b)
% Input: img1, img2, img3  ... path to color channel images
% Output: rgb              ... aligned RGB  image
%% Read images
r = imread(img_r);
g = imread(img_g);
b = imread(img_b);
%% Calculate NCC
[i,j] = meshgrid(-15:1:15,-15:1:15);
shift = [i(:),j(:)];
% Maximum correlation
max_corr_rg = -1;
max_corr_rb = -1;
for k = 1:size(shift, 1)
    l = shift(k, 1:2);
    g_shifted = circshift(g, l);
    b_shifted = circshift(b, l);
    ncc_rg = corr2(r, g_shifted);
    ncc_rb = corr2(r, b_shifted);
    if (ncc_rg > max_corr_rg )
        max_corr_rg = ncc_rg;
        g_shifted_correct = g_shifted;
    end
    if (ncc_rb > max_corr_rb )
        max_corr_rb = ncc_rb;
        b_shifted_correct = b_shifted;
    end    
end
%% Create RGB image
rgb = cat(3,r,g_shifted_correct, b_shifted_correct);
original_name = strsplit(img_r, '_');
filename = strcat(original_name(1), '_RGB.jpg');
filename = strjoin(filename);
imshow(rgb);
imwrite(rgb, filename);
end

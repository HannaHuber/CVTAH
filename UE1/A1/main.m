%% Assignment I/1: Colorizing Images
% Authors: Tomas Musil, Andreas Wittmann, Hanna Huber
function [] = main(img_r, img_g, img_b)
% Input: img1, img2, img3  ... path to color channel images
% Output (saved): rgb      ... aligned RGB  image
%% Read images
r = imread(img_r);
g = imread(img_g);
b = imread(img_b);
%% Calculate NCC
% Vector containing shift indices (row - column)
[i,j] = meshgrid(-15:1:15,-15:1:15);
shift = [i(:),j(:)];
% Maximum correlation
max_corr_rg = -1;
max_corr_rb = -1;
% Iterate over all possible shift combinations
for k = 1:size(shift, 1)
    l = shift(k, 1:2);
    % Shift G and B channel (R channel fixed)
    g_shifted = circshift(g, l);
    b_shifted = circshift(b, l);
    % Calculate NCC between R and shifted G/B image
    ncc_rg = corr2(r, g_shifted);
    ncc_rb = corr2(r, b_shifted);
    % Save maximum correlation and corresponding image (G)
    if (ncc_rg > max_corr_rg )
        max_corr_rg = ncc_rg;
        g_shifted_correct = g_shifted;
    end
    % Save maximum correlation and corresponding image (B)
    if (ncc_rb > max_corr_rb )
        max_corr_rb = ncc_rb;
        b_shifted_correct = b_shifted;
    end    
end
%% Create RGB image
% Concatenate color channels
rgb = cat(3,r,g_shifted_correct, b_shifted_correct);
% Create filename from original filenames
original_name = strsplit(img_r, '_');
filename = strcat(original_name(1), '_RGB.jpg');
filename = strjoin(filename);
% Show and save result
imshow(rgb);
imwrite(rgb, filename);
end

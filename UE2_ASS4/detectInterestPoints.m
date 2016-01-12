%% Assignment 4.A: SIFT Interest Point Detection

function [F, D] = detectInterestPoints( impath, plot)
    %%DETECTINTERESTPOINTS detects and plots SIFT features
    %   Input: 
    %   impath  ... path to image
    %   plot    ... true or false (if true, results are plotted)
    %   Output:
    %   F       ... SIFT frames (keypoints) of the image I. Each column
    %               of F is a feature frame and has the format [X;Y;S;TH], where X,Y
    %               is the (fractional) center of the frame, S is the scale and TH is
    %               the orientation (in radians).
    %   D       ... SIFT descriptors. Each column of D is the descriptor of 
    %               the corresponding frame in F. A descriptor is a 128-dimensional vector of class UINT8.

    %% Read and convert image
    img = imread(char(impath));
    img_gray = rgb2gray(img);
    img_single = im2single(img_gray);
    %% Detect SIFT features
    [F,D] = vl_sift(img_single);
    %% Plot results    
    if plot
        figure('Name','A: Detected Interest Points')
        imshow(img);
        hold on
        vl_plotframe(F);
    end
    
    
end


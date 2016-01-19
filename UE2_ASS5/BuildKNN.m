function [training, group] = BuildKNN(folder, C)
%BUILDKNN Summary of this function goes here
%   Input:
%   folder       ... Path to the folder that contains all category subfolders
%   C            ... 128xnum_clusters matrix containing the SIFT feature
%                    vector for each cluster center
%   Output:
%   training     ... A 800x50 Matrix where each row represent one image.
%                    The columns represent a normalized histogram, sums up 
%                    the number of occurences of every word
%   group        ... A 1x800 vector indicating class labels of every image



%% Init
% Get all subfolders
subfolders = dir(folder);
% Remove ".." and "."
subfolders = subfolders(3:end);
subfolders(1) = []; % REMOVEEEEEEEE

% matrix for histogram values
histogram = zeros(800, 50);

%% Extract SIFT features from all images from all subfolders
for i = 1:8
    s = subfolders(i);
    % Get all images from subfolder
    images = dir(strcat(folder,'/',s.name));
    images = images(3:end);
    for j = 1:100
        % Read and convert image
        img = imread(strcat(folder,'/',s.name, '/',images(j).name));
        if (size(img,3)>1)
            img = rgb2gray(img);
        end
        img_single = im2single(img);
        % Grid size for feature extraction (dense)
        step = 2;
        [~, D] = vl_dsift(img_single, 'step', step, 'fast');
        % build histogram for this image
        % look for nearest neighbour
        nearest_neighbours = knnsearch(C',D');
        % count number of occurences of each class
        bincounts = histc(nearest_neighbours, 1:50);
        % add to histogram matrix
        histogram((i-1)*100 + j, :) = bincounts'; 
    end
end

training = histogram;

% create group vector that indicates the class labels of the 800 images
classes = 8;
imgs_per_class = 100;
group = repmat(1:classes, imgs_per_class, 1); 
group = group(1:end)';
end


function [ output_args ] = ClassifyImages(folder,C,training,group)
%CLASSIFYIMAGES 
%
%BUILDKNN Summary of this function goes here
%   Input:
%   folder       ... Path to the folder that contains all category subfolders
%   C            ... 128xnum_clusters matrix containing the SIFT feature
%                    vector for each cluster center
%   training     ... A 800x50 Matrix where each row represent one image.
%                    The columns represent a normalized histogram, sums up 
%                    the number of occurences of every word
%   group        ... A 1x800 vector indicating class labels of every image
%
%   Output:
%   output_args  ... A 1x8 matrix containing amount of correctly
%                    classified images

%% Init
% Get all subfolders
subfolders = dir(folder);
% Remove ".." and "."
subfolders = subfolders(3:end);

% counter
output_args = zeros(1,max(group(:)));

%% Extract SIFT features from all images from all subfolders
for i = 1:size(subfolders, 1)
    s = subfolders(i);
    % Get all images from subfolder
    images = dir(strcat(folder,'/',s.name));
    images = images(3:end);
    for j = 1:size(images, 1)
        % Read and convert image
        img = imread(strcat(folder,'/',s.name, '/',images(j).name));
        if (size(img,3)>1)
            img = rgb2gray(img);
        end
        img_single = im2single(img);
        % Grid size for feature extraction (dense)
        step = 2;
        [~, D] = vl_dsift(img_single, 'step', step, 'fast');
        % look for nearest neighbour
        nearest_neighbours = knnsearch(C',D');
        % count number of occurences of each class
        bincounts = histc(nearest_neighbours, 1:50);  
        % check to which histogram belongs this image
        classifiedGroup = knnclassify(bincounts', training, group);
        
        if(classifiedGroup == i)
            output_args(i) = output_args(i) + 1;
        end
    end
end

end


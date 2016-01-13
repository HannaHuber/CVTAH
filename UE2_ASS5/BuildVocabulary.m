%TODO: Hanna

function C = BuildVocabulary( folder, num_clusters )
%BUILDVOCABULARY Builds vocabulary of visual words for scene recognition
%   Input:
%   folder       ... Path to the folder that contains all category subfolders
%   num_clusters ... number of clusters
%   Output:
%   C            ... 128xnum_clusters matrix containing the SIFT feature
%                    vector for each cluster center

%% Init
% Get all subfolders
subfolders = dir(folder);
% Remove ".." and "."
subfolders = subfolders(3:end);
% SIFT features (100 per image, 100 images per subfolder, 8 subfolders)
features = zeros(128,80000);
%% Extract features from all images from all subfolders
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
        step = 10;
        [~, D] = vl_dsift(img_single, 'step', step, 'fast');
        % Select random sample (100 points per image)
        num_keypoints = size(D,2);
        rand_indices = randsample(1:num_keypoints,100);
        % Store selected points in feature matrix
        features(:,(i-1)*10000 + (j-1)*100 + (1:100)) = D(:,rand_indices);        
    end
end
%% Cluster features
[C, ~] = vl_kmeans(features, num_clusters);

end


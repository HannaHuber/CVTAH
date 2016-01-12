% calculates the best Homography
% returns H: TFORM including best homography
% returns I: a N x 4 Matrix where the first two columns are x,y coords of
% inliers from img1 and column 3 and 4 are the x and y coords of the
% inliers from img2
function [H, I] = calcHomography(points_img1, points_img2, matching_indices)
%  Randomly choose four matches, i.e. four points of the first image and the corresponding
% four points of the second image. The function randsample might be
% helpful.
chooseNewPoints = true;
best_homography = -1;
best_inlier_sum = -1;
N = 1000; % run RANSAC N times

for i = 0:N
    while chooseNewPoints == true
        chooseNewPoints = false;
        rand_indices_img1 = randsample(matching_indices(1,:), 4);
        % we sort it because ismember gives us the rows_of_randIndices in
        % sorted order. Otherwise we would create wrong correspondences.
        rand_indices_img1 = sort(rand_indices_img1);
        rand_points_img1 = points_img1(1:2, rand_indices_img1)';

        % Give "true" if the element in rand_indices_img1 is a member of matching_indices.
        columns_of_randIndices = ismember(matching_indices(1,:), rand_indices_img1);
        rand_indices_img2 = matching_indices(2, columns_of_randIndices);
        rand_points_img2 = points_img2(1:2, rand_indices_img2)';

        % Estimate the homography between these points using cp2tform. Choose 'projective'
        % as transformation type. Attention: cp2tform will throw an error if the four point
        % pairs are not chosen properly (e.g. three of them lie on the same line). The easiest
        % way to handle this is to use a try-catch-block when calling cp2tform.
        try 
            TFORM = cp2tform(rand_points_img1, rand_points_img2, 'projective');
        catch exception
            chooseNewPoints = true;
        end
    end
    chooseNewPoints = true; %for next RANSAC loop
    
    % Transform all other points of putative matches in the first image using tformfwd.
    % create matrices of corresponding points
    matching_points_img1 = points_img1(1:2, matching_indices(1,:));
    matching_points_img2 = points_img2(1:2, matching_indices(2,:));
    %delete the four randomly chosen points
    matching_points_img1 = matching_points_img1(:, ~columns_of_randIndices);
    matching_points_img2 = matching_points_img2(:, ~columns_of_randIndices);

    matching_points_img1_transformed = zeros(size(matching_points_img1'));
    [matching_points_img1_transformed(:,1), matching_points_img1_transformed(:,2)] = tformfwd(TFORM, matching_points_img1(1,:)', matching_points_img1(2,:)');

    % Determine the number of inliers: compute the Euclidean distance between the transformed
    % points of the first image and the corresponding points of the second image
    % and count a match as inlier, if the distance is under a certain threshold T (e.g.
    % T = 5).
    % calc euclid distance
    matching_points_euclid = zeros(size(matching_points_img1_transformed));
    matching_points_euclid(:,1) = sqrt((matching_points_img1_transformed(:,1) - matching_points_img2(1,:)') .^2);
    matching_points_euclid(:,2) = sqrt((matching_points_img1_transformed(:,2) - matching_points_img2(2,:)') .^2);
    % find inliers
    threshold = 5;
    inlier_index = (matching_points_euclid(:,1) < threshold) & (matching_points_euclid(:,2) < threshold); 
    %sum up the inliers
    inlier_sum = sum(inlier_index);

    if (inlier_sum > best_inlier_sum)
       best_inlier_sum = inlier_sum;
       best_homography = TFORM;
    end

end
% After the N runs, take the homography that had the maximum number of inliers.
% TODO Reestimate the homography with all inliers to obtain a more accurate result.
% transform images with best homography

% Transform all points of putative matches in the first image using tformfwd with best_homography.
% create matrices of corresponding points
matching_points_img1 = points_img1(1:2, matching_indices(1,:));
matching_points_img2 = points_img2(1:2, matching_indices(2,:));

matching_points_img1_transformed = zeros(size(matching_points_img1'));
[matching_points_img1_transformed(:,1), matching_points_img1_transformed(:,2)] = tformfwd(best_homography, matching_points_img1(1,:)', matching_points_img1(2,:)');

% find inliers

% Determine the number of inliers: compute the Euclidean distance between the transformed
% points of the first image and the corresponding points of the second image
% and count a match as inlier, if the distance is under a certain threshold T (e.g.
% T = 5).
% calc euclid distance
matching_points_euclid = zeros(size(matching_points_img1_transformed));
matching_points_euclid(:,1) = sqrt((matching_points_img1_transformed(:,1) - matching_points_img2(1,:)') .^2);
matching_points_euclid(:,2) = sqrt((matching_points_img1_transformed(:,2) - matching_points_img2(2,:)') .^2);
    
threshold = 5;
inlier_index = (matching_points_euclid(:,1) < threshold) & (matching_points_euclid(:,2) < threshold); 
% get inlier points
inlier_points_img1 = matching_points_img1(1:2, inlier_index)';
inlier_points_img2 = matching_points_img2(1:2, inlier_index)';

% calculate final homography with all inliers
final_homography = cp2tform(inlier_points_img1, inlier_points_img2, 'projective');

H = final_homography;
I = [inlier_points_img1, inlier_points_img2];
end

%% TODO B.) 3-4:
% 3. You will recognize that not all matches are correct, i.e. some matches can be considered
% as outliers. Therefore, apply the RANSAC scheme to estimate the homography between
% the first and the second image. For this purpose, perform the following steps N times
% (e.g. N = 1000):
% (a) Randomly choose four matches, i.e. four points of the first image and the corresponding
% four points of the second image. The function randsample might be
% helpful.
% (b) Estimate the homography between these points using cp2tform. Choose 'projective'
% as transformation type. Attention: cp2tform will throw an error if the four point
% pairs are not chosen properly (e.g. three of them lie on the same line). The easiest
% way to handle this is to use a try-catch-block when calling cp2tform.
% (c) Transform all other points of putative matches in the first image using tformfwd.
% (d) Determine the number of inliers: compute the Euclidean distance between the transformed
% points of the first image and the corresponding points of the second image
% and count a match as inlier, if the distance is under a certain threshold T (e.g.
% T = 5).
% 4. After the N runs, take the homography that had the maximum number of inliers. Reestimate
% the homography with all inliers to obtain a more accurate result.
function H = calcHomography(F1, F2, indices)

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
%% Runs LoGBlobDetector
 
%% Hint (see assignment) 
% Parameter selection: You have to choose the initial scale 0, the factor k by which the
% scale is multiplied each time and the number of levels in the scale space. A reasonable
% choice is for instance sigma0 = 2, k = 1.25 and 10 levels.

%% Select parameters
sigma0 = 2;
k = 1.25;
levels = 10;
%% Select image
img_path = './imgs/butterfly.jpg';
%% Run blob detector
LoGBlobDetector(img_path, sigma0, k, levels);

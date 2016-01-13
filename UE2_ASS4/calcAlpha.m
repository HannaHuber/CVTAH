function [ alpha_channel ] = calcAlpha( h, w )
%% Calculates aplha channel
    %   Input: 
    %   h ... height of resulting aplha channel image
    %   w ... width of resulting aplha channel image

    %   Output:
    %   alpha_channel ... alpha channel image
    
%% Initialize alpha channel with zeros
alpha_channel = zeros(h,w);

%% Set border pixels to 1
alpha_channel(:,w) = 1;
alpha_channel(h,:) = 1;
alpha_channel(1,:) = 1;
alpha_channel(:,1) = 1;

%% Distance transform of binary image
alpha_channel = bwdist(alpha_channel, 'Quasi-Euclidean');
% tranform values between 0 and 1
alpha_channel = alpha_channel / max(alpha_channel(:));
% transform values between 0 and 255 (because of single precision)
alpha_channel = alpha_channel * 255;

end


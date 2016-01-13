function mosaic = blendImages(I1,I2,I3,I4,I5, mosaicType)
%% Stitches images together to get one mosaic image
    %   Input: 
    %   I1...I5    ... transformed and rotated images
    %   mosaicType ... which type of blending algorithm should be used:
    %                  either feathering or no_feathering
    %   Output:
    %   mosaic     ... stitched images
    
% Given all transformed images, the final step is to blend overlapping pixel color values in
% such a way as to avoid seams. One simple way to do this, called feathering, is to use
% weighted averaging of the color values to blend overlapping pixels. To do this use an
% channel where the value of for an image is 0 at all the border pixels and 1 at the
% 3
% maximum distance from the border. The remaining values are linearly interpolated (the
% function bwdist can be used for this task). These -images are also transformed to the
% reference coordinate system and the final color at a pixel in the output image is computed
% as the weighted sum of overlapping images. More precisely, if there are n images
% overlapping at pixel position (x; y), Ii(x; y), i = 1 : : : n with color values (Ri;Gi;Bi)
% and weighting factors i, the color values in the stitched output image O are computed
% as:
% O(x; y) = [sum((RPi;Gi;Bi)*alpha_i)]/[sum(alphai_i)]

%% Init values
[h, l, ~] = size(I1);
mosaic = uint8(zeros([h,l,3]));
m = uint8(zeros([h,l,4]));

I1 = double(I1);
I2 = double(I2);
I3 = double(I3);
I4 = double(I4);
I5 = double(I5);

%% feathering Algorithm
if(strcmp(mosaicType,'feathering') == 1)
    mosaic(:,:,1) = (I1(:,:,1) .* I1(:,:,4) + I2(:,:,1) .* I2(:,:,4) + I3(:,:,1) .* I3(:,:,4) + I4(:,:,1) .* I4(:,:,4) + I5(:,:,1) .* I5(:,:,4)) ./ (I1(:,:,4) + I2(:,:,4) + I3(:,:,4) + I4(:,:,4) + I5(:,:,4));
    mosaic(:,:,2) = (I1(:,:,2) .* I1(:,:,4) + I2(:,:,2) .* I2(:,:,4) + I3(:,:,2) .* I3(:,:,4) + I4(:,:,2) .* I4(:,:,4) + I5(:,:,2) .* I5(:,:,4)) ./ (I1(:,:,4) + I2(:,:,4) + I3(:,:,4) + I4(:,:,4) + I5(:,:,4));
    mosaic(:,:,3) = (I1(:,:,3) .* I1(:,:,4) + I2(:,:,3) .* I2(:,:,4) + I3(:,:,3) .* I3(:,:,4) + I4(:,:,3) .* I4(:,:,4) + I5(:,:,3) .* I5(:,:,4)) ./ (I1(:,:,4) + I2(:,:,4) + I3(:,:,4) + I4(:,:,4) + I5(:,:,4));
%% non feathering Algorithm .. consecutive algorithm
elseif(strcmp(mosaicType,'no_feathering') == 1)
    m(I1>0) = I1(I1 > 0);
    m(I2>0) = I2(I2 > 0);
    m(I3>0) = I3(I3 > 0);
    m(I4>0) = I4(I4 > 0);
    m(I5>0) = I5(I5 > 0);
    
    % use only color dimensions for resulting image
    mosaic = m(:,:,1:3);
end

end
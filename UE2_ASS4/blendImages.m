function mosaic = blendImages(I1,I2,I3,I4,I5, mosaic_size)
% TODO
% Given all transformed images, the final step is to blend overlapping pixel color values in
% such a way as to avoid seams. One simple way to do this, called feathering, is to use
% weighted averaging of the color values to blend overlapping pixels. To do this use an
% -channel where the value of  for an image is 0 at all the border pixels and 1 at the
% 3
% maximum distance from the border. The remaining values are linearly interpolated (the
% function bwdist can be used for this task). These -images are also transformed to the
% reference coordinate system and the final color at a pixel in the output image is computed
% as the -weighted sum of overlapping images. More precisely, if there are n images
% overlapping at pixel position (x; y), Ii(x; y), i = 1 : : : n with color values (Ri;Gi;Bi)
% and weighting factors i, the color values in the stitched output image O are computed
% as:
% O(x; y) = [sum((RPi;Gi;Bi)*alpha_i)]/[sum(alphai_i)]

end
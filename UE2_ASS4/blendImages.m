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
[h, l, d] = size(I1);
mosaic = uint8(zeros([h,l,3]));

%% Go through all pixels
for x = 1:h
    for y = 1:l
        
        % Init variablen
        r = 0;
        g = 0;
        b = 0;
        alpha_sum = 0;
        
        %% feathering Algorithm
        if(strcmp(mosaicType,'feathering') == 1)
        
        % when alpha value is non zero, update rgb and sum of aplha
        % I1
        alphaI1 = double(I1(x,y,4)) / 255;
        if(alphaI1 ~= 0)
            r = r + (double(I1(x,y,1)) * alphaI1);
            g = g + (double(I1(x,y,2)) * alphaI1);
            b = b + (double(I1(x,y,3)) * alphaI1);
            alpha_sum = alpha_sum + alphaI1;
        end
        
        % I2
        alphaI2 = double(I2(x,y,4)) / 255;
        if(alphaI2 ~= 0)
            r = r + (double(I2(x,y,1)) * alphaI2);
            g = g + (double(I2(x,y,2)) * alphaI2);
            b = b + (double(I2(x,y,3)) * alphaI2);
            alpha_sum = alpha_sum + alphaI2;
        end
        
        % I3
        alphaI3 = double(I3(x,y,4)) / 255;
        if(alphaI3 ~= 0)
            r = r + (double(I3(x,y,1)) * alphaI3);
            g = g + (double(I3(x,y,2)) * alphaI3);
            b = b + (double(I3(x,y,3)) * alphaI3);
            alpha_sum = alpha_sum + alphaI3;
        end
        
        % I4
        alphaI4 = double(I4(x,y,4)) / 255;
        if(alphaI4 ~= 0)
            r = r + (double(I4(x,y,1)) * alphaI4);
            g = g + (double(I4(x,y,2)) * alphaI4);
            b = b + (double(I4(x,y,3)) * alphaI4);
            alpha_sum = alpha_sum + alphaI4;
        end
        
        % I5
        alphaI5 = double(I5(x,y,4)) / 255;
        if(alphaI5 ~= 0)
            r = r + (double(I5(x,y,1)) * alphaI5);
            g = g + (double(I5(x,y,2)) * alphaI5);
            b = b + (double(I5(x,y,3)) * alphaI5);
            alpha_sum = alpha_sum + alphaI5;
        end
        
        % Normalize rbg and fill mosaic
        mosaic(x,y,1) = r / alpha_sum;
        mosaic(x,y,2) = g / alpha_sum;
        mosaic(x,y,3) = b / alpha_sum;
        
        %% No feathering algorithm. RGB pixel from one image is used
        elseif(strcmp(mosaicType,'no_feathering') == 1)
            % when alpha value is non zero, use those rgb colors for resulting image
            % I1
            if(I1(x,y,4) ~= 0)
                r = I1(x,y,1);
                g = I1(x,y,2);
                b = I1(x,y,3);
            end
            
            % I2
            if(I2(x,y,4) ~= 0)
                r = I2(x,y,1);
                g = I2(x,y,2);
                b = I2(x,y,3);
            end
            
            % I3
            if(I3(x,y,4) ~= 0)
                r = I3(x,y,1);
                g = I3(x,y,2);
                b = I3(x,y,3);
            end
            
            % I4
            if(I4(x,y,4) ~= 0)
                r = I4(x,y,1);
                g = I4(x,y,2);
                b = I4(x,y,3);
            end
            
            % I5
            if(I5(x,y,4) ~= 0)
                r = I5(x,y,1);
                g = I5(x,y,2);
                b = I5(x,y,3);
            end
            
            % save rgb values in resulting image
            mosaic(x,y,1) = r;
            mosaic(x,y,2) = g;
            mosaic(x,y,3) = b;
        end
    end
end

end
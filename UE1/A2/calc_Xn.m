function [Xn] = calc_Xn(img, d3_or_d5 )
%% Input: 
%   img       ... original image (which should be clustered)
%   3D_or_5D  ... '3D' if it should only use color information for
%   clustering, '5D' if it should use color and spatial information for
%   clustering
% Output: a 3xN or 5xN matrix (Columns: r, g, b, x Coord, y Coord)

%normalize img to the range [0 1]
img = im2double(img);
%get the r,g,b values
img_r = img(:,:,1);
img_g = img(:,:,2);
img_b = img(:,:,3);

%create x_n array
Xn = [reshape(img_r, 1, []); reshape(img_g, 1, []); reshape(img_b, 1, [])];

%if 5D calc x-coordinates and ycoordinates for each pixel and save to x_n
if(strcmp(d3_or_d5, '5D'))
   xcoords = repmat(1:size(img,2), size(img, 1), 1);
   xcoords = xcoords(:)';
   
   %normalize to 0 1
   range = max(xcoords) - min(xcoords);
   xcoords = (xcoords - min(xcoords)) / range;
   
   ycoords = (1:size(img,1));
   ycoords = repmat(ycoords, 1, size(img,2));
   
   %normalize to 0 1
   range = max(ycoords) - min(ycoords);
   ycoords = (ycoords - min(ycoords)) / range;
 
   Xn = [Xn; xcoords;  ycoords];
end

end


function [] = main()
%MAIN Summary of this function goes here
%   Detailed explanation goes here
    impath = cell(5,1);
    impath(1) = cellstr('ass4_data/campus1.jpg');
    impath(2) = cellstr('ass4_data/campus2.jpg');
    impath(3) = cellstr('ass4_data/campus3.jpg');
    impath(4) = cellstr('ass4_data/campus4.jpg');
    impath(5) = cellstr('ass4_data/campus5.jpg');
    
    mosaic = stitchImages(impath);

end


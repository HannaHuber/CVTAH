function [ H_rel ] = calcRelativeTransformation( H )
% H     ... 1x5 cell of consecutive homographies
% H_rel ... 1x5 cell of homographies relative to reference (index 3)
%% Init cell of relative homographies
H_rel = cell(1,5);
%% Calculate composite homographies
% From img1 to img3
H_rel{1} = H{2}.tdata.T * H{1}.tdata.T;
% From img2 to img3
H_rel{2} = H{2}.tdata.T;
% img3 = reference image --> transformation = identity
H_rel{3} = eye(3);
% From img4 to img3
H_rel{4} = H{3}.tdata.Tinv;
% From img5 to img3
H_rel{5} = H{3}.tdata.Tinv * H{4}.tdata.Tinv;

end


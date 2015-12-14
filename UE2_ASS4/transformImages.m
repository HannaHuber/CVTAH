function transformed = transformImages(H,I, xy_min, xy_max)
% TODO C.4
n = size(I);
transformed = cell(1,n);
for i=1:n
    transformed{i} = imtransform(I{i},H{i},'XData',[ xy_min(1) xy_max(1)], 'YData',[ xy_min(2) xy_max(2)]);
end

end
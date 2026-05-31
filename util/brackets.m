function [bracketImage] = brackets(im,minValue,maxValue,frange),

im = double(im);
minValue = double(minValue);
maxValue = double(maxValue);

if nargin == 3,
frange = 255;
end,

%minValue = min(min(im));
%maxValue = max(max(im));
bracketImage = uint8(frange * (im-minValue) / (maxValue - minValue));

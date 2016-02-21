%Förstner line extractor
%returns Region object containing all lines
%sigma: for Gaussian (scale)
%t_h: threshold for eigenvalue relation e_1+e_2 of structure tensor
function [lines] = foerstnerLines(img, sigma, t_h)
addpath('core');

%image gradients for structure tensor
%for whole img (speed)
[Ix, Iy] = imgGradients(img);

%gaussian filter/kernel of size (2*sigma+1)*(2*sigma+1) and standard deviation sigma
g = fspecial('gaussian', (2*sigma+1), sigma);

%apply gaussian to components of structure tensor via 2d convolution
Ix2 = conv2(Ix.^2, g, 'same');
Iy2 = conv2(Iy.^2, g, 'same');

%compute traces
traces = Ix2+Iy2;
figure; imagesc(traces); axis('image')

%find lines (gives binary image)
RES = (traces>t_h);
%figure; imagesc(RES); axis('image')

%extract lines from binary image into a region representation
lines = Region();
lines.extractBows(RES);
lines.pack();

end
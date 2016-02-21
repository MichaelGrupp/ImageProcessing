%Harris & Stephens corner detector
%returns X and Y coordinates of detected feature points
function [X, Y] = harrisCorners(img, k, sigma, theta)
addpath('core');

%image gradients for structure tensor
%for whole img (speed)
[Ix, Iy] = imgGradients(img);

%gaussian filter/kernel of size (2*sigma+1)*(2*sigma+1) and standard deviation sigma
g = fspecial('gaussian', (2*sigma+1), sigma);

%apply gaussian to components of structure tensor via 2d convolution
Ix2 = conv2(Ix.^2, g, 'same');
Iy2 = conv2(Iy.^2, g, 'same');
Ixy = conv2(Ix.*Iy, g, 'same');

%compute scoring matrix C
%using determinants of all pixels' structure tensors and their square traces
%(trace is the sum of main diagonal of each pixel's M)
det = [(Ix2.*Iy2) - (Ixy.*Ixy)];
traces = Ix2+Iy2;
C = det + k*traces.^2;
%figure; imgsc(C); axis('image')

% find local maxima
MAX = imregionalmax(C); %img > imdilate(img, [1 1 1; 1 0 1; 1 1 1]);
RES = MAX & (C>theta);

[Y,X] = find(RES); % find row,col coords of (nonzero) features

end
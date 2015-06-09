%Harris & Stephens corner detector
%returns X and Y coordinates of detected feature points
function [X, Y] = harrisCorners(img, k, sigma, theta)

%components of structure tensor
%for whole img (speed)
[Ix2, Iy2, Ixy] = structureTensor(img, sigma);
M = [Ix2, Ixy; Ixy, Iy2];

%compute scoring matrix C
%using determinants of all pixels' structure tensors and their square traces
%(trace is the sum of main diagonal of each pixel's M)
det = [(Ix2.*Iy2) - (Ixy.*Ixy)];
traces = Ix2+Iy2;
C = det + k*traces.^2;
%figure; imgsc(C); axis('image')

% find local maxima
MAX = imregionalmax(C); %img > imdilate(img, [1 1 1; 1 0 1; 1 1 1]);
C = MAX & (C>theta);

[Y,X] = find(C); % find row,col coords of (nonzero) features

end
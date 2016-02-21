%Förstner point extractor
%returns X and Y coordinates of detected feature points
%sigma: for Gaussian (scale)
%t_v: threshold for eigenvalue relation e_2/e_1 of structure tensor
function [X, Y] = foerstnerPoints(img, sigma, t_v)
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

%compute form factor (here: matrix) Q
%approximation of eigenvalues
det = [(Ix2.*Iy2) - (Ixy.*Ixy)];
traces = Ix2+Iy2;
Q = 4.*det ./ (traces.^2);
Q(isnan(Q)) = 0; %remove NaNs 
figure; imagesc(Q); axis('image')

%find local maxima
%transform Eigenvalue threshold t_v to suit form factor Q approximation
t_q = 4*t_v / (1+t_v)^2;
%MAX = imregionalmax(Q); %non-maximum suppresion
%figure; imagesc(MAX); axis('image')
RES =  (Q>t_q);

[Y,X] = find(RES); % find row,col coords of (nonzero) features

end
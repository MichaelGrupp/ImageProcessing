function [Ix, Iy] = imgGradients(img)
 
%gradient kernels
%source: http://matlabtricks.com/post-5/3x3-convolution-kernels-with-online-demo#demo
dx = [-1 0 1; -1 0 1; -1 0 1];
dy = dx';

%compute image gradients using 2d convolution with kernels
Ix = conv2(img, dx, 'same');
Iy = conv2(img, dy, 'same');


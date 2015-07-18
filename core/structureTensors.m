%compute components of structure tensors for all pixels of an image
function [Ix2, Iy2, Ixy] = structureTensors(img, sigma)
    %gradient kernels
    %source: http://matlabtricks.com/post-5/3x3-convolution-kernels-with-online-demo#demo
    dx = [-1 0 1; -1 0 1; -1 0 1];
    dy = dx';
    
    %compute image gradients using 2d convolution with kernels
    Ix = conv2(img, dx, 'same');
    Iy = conv2(img, dy, 'same');    

    %gaussian filter/kernel of size (2*sigma+1)*(2*sigma+1) and standard deviation sigma
    g = fspecial('gaussian', (2*sigma+1), sigma);
    
    %apply gaussian to components of structure tensor via 2d convolution
    Ix2 = conv2(Ix.^2, g, 'same');
    Iy2 = conv2(Iy.^2, g, 'same');
    Ixy = conv2(Ix.*Iy, g, 'same');
end

addpath('core')

close all;
%works only with double!!
img = im2double(imread('testImages/cameraman.png'));
if (ndims(img)==3)
    img=rgb2gray(img);
end

filterSize = 10;
sigma = filterSize/2;

imgOutMF = meanFilter(img, filterSize);
imgOutGF = gaussianFilter(img, filterSize, sigma);

figure;
subplot(1,3,1), subimage(img), title('original')
subplot(1,3,2), subimage(imgOutMF), title('mean filtered')
subplot(1,3,3), subimage(imgOutGF), title('gaussan filtered')
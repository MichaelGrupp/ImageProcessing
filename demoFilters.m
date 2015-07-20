addpath('core')
profile on;

close all;
%works only with double!!
img = im2double(imread('testImages/lenna.jpg'));
if (ndims(img)==3)
    img=rgb2gray(img);
end

filterSize = 10;
sigma = filterSize/2;

imgOutMF = meanFilter(img, filterSize);
imgOutGF = gaussianFilter(img, filterSize, sigma);
imgOutME = medianFilter(img, filterSize);

figure;
subplot(2,2,1), subimage(img), title('original')
subplot(2,2,2), subimage(imgOutMF), title('mean filtered')
subplot(2,2,3), subimage(imgOutGF), title('gaussian filtered')
subplot(2,2,4), subimage(imgOutME), title('median filtered')

profile viewer
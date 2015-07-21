addpath('core')
%profile on;

close all;
%works only with double!!
img = im2double(imread('testImages/inpImg.png'));
if (ndims(img)==3)
    img=rgb2gray(img);
end

filterSize = 10;
sigma = filterSize/2;
imgOut = gaussianFilter(img, filterSize, sigma);

t = segmentationThreshold(imgOut);
var = 0.5; %variation level
imgOut = separateAtThreshold(imgOut, t, var);

subplot(2,1,1), subimage(img), title('original')
subplot(2,1,2), subimage(imgOut), title('segmentated')
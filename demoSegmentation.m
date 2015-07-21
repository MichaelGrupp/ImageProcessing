addpath('core')

close all; clear all;
%works only with double!!
img = im2double(imread('testImages/inpImg.png'));
if (ndims(img)==3)
    img=rgb2gray(img);
end

filterSize = 10;
sigma = filterSize/2;
imgOut = gaussianFilter(img, filterSize, sigma);

t = segmentationThreshold(imgOut);
var = 3; %variation level
imgOut = separateAtThreshold(imgOut, t, var);

%memory efficient storage in Region object
sepRegion = Region;
sepRegion.extractBows(imgOut);
imgBows = sepRegion.draw();

subplot(3,1,1), subimage(img), title('original')
subplot(3,1,2), subimage(imgOut), title('segmentated')
subplot(3,1,3), subimage(imgBows), title('reconstructed bows of Region object')
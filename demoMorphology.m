addpath('core')

close all; clear all;
%works only with double!!
img1 = im2double(imread('testImages/morph1.png'));
img2 = im2double(imread('testImages/morph2.png'));
if (ndims(img1)==3)
    img1=rgb2gray(img1);
end
if (ndims(img2)==3)
    img2=rgb2gray(img2);
end

filterSize = 10;
sigma = filterSize/2;
imgOut1 = gaussianFilter(img1, filterSize, sigma);
imgOut2 = gaussianFilter(img2, filterSize, sigma);

%segmentate
var = 1.5; %variation level
t1 = segmentationThreshold(imgOut1);
imgOut1 = separateAtThreshold(imgOut1, t1, var);
t2 = segmentationThreshold(imgOut2);
imgOut2 = separateAtThreshold(imgOut2, t2, var);

%memory efficient storage in Region object
Region1 = Region;
Region1.extractBows(imgOut1);
Region2 = Region;
Region2.extractBows(imgOut2);

%the morphological step
Merged = Region.merge(Region1,Region2);

imgMerged = Merged.draw();

subplot(4,1,1), subimage(img1), title('original')
subplot(4,1,2), subimage(imgOut1), title('segmentated')
subplot(4,1,3), subimage(imgOut2), title('segmentated rotated')
subplot(4,1,4), subimage(imgMerged), title('morphological step')
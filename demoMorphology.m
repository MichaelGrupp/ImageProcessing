addpath('core')

close all; clear all;
%works only with double!!
img1 = im2double(imread('testImages/morph2.png'));
img2 = im2double(imread('testImages/cameraman.png'));
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
var = 5; %variation level
t1 = segmentationThreshold(imgOut1);
imgOut1 = separateAtThreshold(imgOut1, t1, var);
t2 = segmentationThreshold(imgOut2);
imgOut2 = separateAtThreshold(imgOut2, t2, var);

%memory efficient storage in Region object
Region1 = Region;
Region1.extractBows(imgOut1);
Region2 = Region;
Region2.extractBows(imgOut2);

%% the morphological steps
Region3 = Region.merge(Region1,Region2);
%pack overlapping bows to save memory
Region3.pack();
Region3 = Region.translate(Region3, [-50,20]);

%% plot
imgMerged = Region3.draw();

subplot(3,2,1), subimage(img1), title('image 1')
subplot(3,2,2), subimage(imgOut1), title('region 1')
subplot(3,2,3), subimage(img2), title('image 2')
subplot(3,2,4), subimage(imgOut2), title('region 2')
subplot(3,2,6), subimage(imgMerged), title('after morphological steps')
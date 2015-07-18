addpath('core')

close all;
image = imread('testImages/cameraman.png');
if (ndims(image)==3)
    image=rgb2gray(image);
end

aRate = 1.2; % <1 for less, >1 for more contrast
bRate = 0.5; % <0 for less, >0 for more brightness
imageOut = contrastNormalization(image, aRate, bRate);

figure;
subplot(1,2,1), subimage(image)
subplot(1,2,2), subimage(imageOut)
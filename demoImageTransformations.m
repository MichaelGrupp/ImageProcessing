addpath('core')

close all;
image = imread('testImages/lenna.jpg');
if (ndims(image)==3)
    image=rgb2gray(image);
end

aRate = 1.2; % <1 for less, >1 for more contrast
bRate = 1.5; % <0 for less, >0 for more brightness
imageCN = contrastNormalization(image, aRate, bRate);

pLow = 0.01; % lower fraction of cumulative histogram to be ignored
pUp = 0.9; % 1-upper fraction of cumulative histogram to be ignored
imageCNR = contrastNormalizationRobust(image, aRate, bRate, pUp, pLow);

figure;
subplot(1,3,1), subimage(image), title('original')
subplot(1,3,2), subimage(imageCN), title('contrast normalization')
subplot(1,3,3), subimage(imageCNR), title('robust contrast normalization')
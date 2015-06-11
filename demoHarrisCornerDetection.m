addpath('featureDetection');

sigma = 3;
k = 0.05;
theta = 3e7;

close all;
image = imread('testImages/lenna.jpg');
if (ndims(image)==3)
    image=rgb2gray(image);
end

[X,Y] = harrisCorners(image, k, sigma, theta);

figure; imshow(image)
hold on;
plot(X,Y, 'r sq','LineWidth',2)%plot detected features
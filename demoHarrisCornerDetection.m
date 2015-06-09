addpath('featureDetection');

sigma = 3;
k = 0.05;
theta = 5e6;

close all;
image = imread('test.jpg');
if (ndims(image)==3)
    image=rgb2gray(image);
end

[r,c] = harrisCorners(image, k, sigma, theta);

figure; imshow(image)
hold on;
plot(c, r, 'ro','LineWidth',2)%plot detected features




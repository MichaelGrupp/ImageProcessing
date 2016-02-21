close all;
addpath('featureDetection');

sigma = 3;
t_v = 0.3; %threshold for points
t_h = 9; %threshold for lines

%close all;
image = imread('testImages/featureTest.png');
if (ndims(image)==3)
    image=rgb2gray(image);
end

%find points
[X,Y] = foerstnerPoints(image, sigma, t_v);

figure; imshow(image)
hold on;
plot(X,Y, 'r X','LineWidth',2)%plot detected features

%find lines
lines = foerstnerLines(image, sigma, t_h);
linesImg = lines.draw();

figure; imshow(linesImg)
hold on;

%find homogeneous regions
hom = foerstnerHomogeneous(image, sigma, t_h);
homImg = hom.draw();

figure; imshow(homImg)
hold on;
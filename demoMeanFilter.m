addpath('core')

close all;
%works only with double!!
img = im2double(imread('testImages/cameraman.png'));
if (ndims(img)==3)
    img=rgb2gray(img);
end

imgOut = meanFilter(img, 10);

figure;
subplot(1,2,1), subimage(img), title('original')
subplot(1,2,2), subimage(imgOut), title('mean filtered')
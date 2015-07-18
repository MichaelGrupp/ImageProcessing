addpath('core')

close all;
img = imread('testImages/inpImg.png');
imgRef = imread('testImages/refImg.png');
if (ndims(img)==3)
    img=rgb2gray(img);
end
if (ndims(imgRef)==3)
    imgRef=rgb2gray(imgRef);
end

imgOut = shadingCorrection(img, imgRef);

figure;
subplot(1,3,1), subimage(img), title('original')
subplot(1,3,2), subimage(imgRef), title('reference')
subplot(1,3,3), subimage(imgOut), title('shading corrected')
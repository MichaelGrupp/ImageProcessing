function [imgOut] = meanFilter(img, size)
kernel = ones(size)*(1/size^2); %kernel (filter window) of mean (sum/n)
imgOut = conv2(kernel, img);
end
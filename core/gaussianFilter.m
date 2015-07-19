function [imgOut] = gaussianFilter(img, size, sigma)
%2D gaussian
[x y]=meshgrid(round(-size/2):round(size/2), round(-size/2):round(size/2));
kernel = exp(-x.^2/(2*sigma^2)-y.^2/(2*sigma^2));
kernel=kernel./sum(kernel(:)); %normalized, sum of all values must be 1

imgOut = conv2(img, kernel, 'same');
end
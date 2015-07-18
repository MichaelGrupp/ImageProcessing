function [imgOut] = shadingCorrection(img, imgRef)
maxRef = max(max(imgRef));
imgOut = img - imgRef+maxRef; %???
end
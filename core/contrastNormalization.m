function [imgOut] = contrastNormalization(img, aRate, bRate)
gMax = double(max(max(img)));
gMin = double(min(min(img)));

a = aRate*(255/(gMax-gMin));

imgOut = (img+gMin*bRate).*a;
end
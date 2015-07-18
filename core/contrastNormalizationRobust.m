function [imgOut] = contrastNormalizationRobust(img, aRate, bRate, pUp, pLow)
cumulative = cumsum(imhist(img));
cSum = cumulative(end);
cLow = pLow*cSum;
cUp = pUp*cSum;

gMax = find(cumulative<cUp, 1, 'last');
gMin = find(cumulative>cLow, 1, 'first');

a = aRate*(255/(gMax-gMin));

imgOut = (img+gMin*bRate).*a;
end
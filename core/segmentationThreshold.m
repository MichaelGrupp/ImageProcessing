function [t] = segmentationThreshold(img)

[COUNTS,X] = imhist(img);

%find local maxima and their location
[P,Loc] = findpeaks(COUNTS);
[maxP, mTemp] = max(P);
m = Loc(mTemp);

[minC, i] = min(COUNTS(m:end));
t = X(i);

end


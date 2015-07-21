function [imgOut] = separateAtThreshold(img, t, var)
[m,n] = size(img);
imgOut = zeros(m,n);

for i = 1:m
    for j = 1:n
        if(img(i,j)>=t+(t*(1/var)))
            imgOut(i,j)=1;
        else
            imgOut(i,j)=0;
        end
    end
end

end
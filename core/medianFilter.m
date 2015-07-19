function [imgOut] = medianFilter(img, fSize)
[m,n] = size(img);
imgOut = zeros(m,n);
kernel = ones(fSize)/fSize^2;
w = round(fSize/2);

for i=1:m
    for j=1:n
        iOffset1=w; iOffset2=w; jOffset1=w; jOffset2=w;
        if(i-w<1)
            iOffset1=w+(i-w)-1;
        end
        if(i+w>m)
            iOffset2=jOffset1-((i+w)-m);
        end
        if(j-w<1)
            jOffset1=w+(j-w)-1;
        end
        if(j+w>n)
            jOffset2=jOffset2-((j+w)-n);
        end
        adjacency = conv2(...
            img(i-iOffset1:i+iOffset2,j-jOffset1:j+jOffset2), ...
            kernel, 'same');
        stacked = adjacency(:);
        stacked = sort(stacked);
        median = stacked(round(end/2));
        imgOut(i,j) = median;
    end
end

end
function wc = whiteCols(a, w, h, whitethreshold)

wc0 = sum(a(:,:,1),1) + sum(a(:,:,2),1) + sum(a(:,:,3),1); %make sum of cols

for col=1:w
    if wc0(col) >= ((3*h*255) - h*whitethreshold)
        wc(col) = 0;    %col is white
    else
        wc(col) = 1;    %col is not white
    end
end

%wr=wr0;

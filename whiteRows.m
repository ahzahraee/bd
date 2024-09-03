function wr = whiteRows(a, w, h, whitethreshold)

wr0 = sum(a(:,:,1),2) + sum(a(:,:,2),2) + sum(a(:,:,3),2); %make sum of rows

for row=1:h
    if wr0(row) >= ((3*w*255) - w*whitethreshold)
        wr(row) = 0;    %row is white
    else
        wr(row) = 1;    %row is not white
    end
end

%wr=wr0;

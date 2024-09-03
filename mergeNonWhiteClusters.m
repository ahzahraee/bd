function mc = mergeNonWhiteClusters(nonwc, threshold, nwc, minheight)

n = nwc;
nonwc(n,3) = 0; %if third coloumn is 1 means that lines should be merged with next line.

%add 3rd colomn to non white cluster matrix
while n>1   
    if (nonwc(n,1) - nonwc(n-1,2))<threshold
        nonwc(n-1,3) = 1;
    else
        nonwc(n-1,3) = 0;
    end
    n=n-1;
end

%mnonwc = nonwc; %non white cluster matrix with the third colomn added

%merge clusters that are closer than threshold number of pixels
nmc = 0;
i=1;
j=1;

while i<=nwc
    if (nonwc(i,3) == 1)
        j=i+1;
        while(nonwc(j,3) == 1)
            j=j+1;
        end
    else
        j=i;
    end
           
    nmc = nmc + 1;
    mc(nmc,1) = nonwc(i,1);
    mc(nmc,2) = nonwc(j,2);
    
    i = j+1;
end


%delete clusters that are too short, e.g. clusters that include page number
while nmc>0
    if (mc(nmc,2) - mc(nmc,1)) < minheight
        mc(nmc,:) = [];
    end
    nmc = nmc -1;
end






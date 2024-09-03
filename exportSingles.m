function exportSingles(image, nwcm,n,border,filepath,imagename,imageformat)

%nwcm: non white clusters matrix
%n: number of non white clusters
%border to add top and bottom of each frame in pixels

for i=1:n
    %filenameOut = char(strcat(filepath,"out/",imagename,"-",string(i),".jpg"));
    filename = char(strcat(imagename,"-",int2str(i),imageformat));
    filenameOut = fullfile(filepath,filename);
    
    if (nwcm(i,1)>border)
        left = nwcm(i,1) - border;
    else
        left = nwcm(i,1);
    end
    
    if (nwcm(i,2)+border) < size(image,2)
        right = nwcm(i,2)+border;
    else
        right = nwcm(i,2);
    end
        
    imwrite(image(:,left:right,:),filenameOut);
end
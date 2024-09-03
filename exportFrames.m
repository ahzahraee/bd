function exportFrames(image, nwcm,n,border_t,border_b,filepath,imagename,imageformat)

%nwcm: non white clusters matrix
%n: number of non white clusters
%border to add top and bottom of each frame in pixels

for i=1:n
    %filenameOut = char(strcat(filepath,"out/",imagename,"-",string(i),".jpg"));
    filename = char(strcat(imagename,"-",int2str(i),imageformat));
    filenameOut = fullfile(filepath,filename);
    
    if (nwcm(i,1)>border_t)
        top = nwcm(i,1) - border_t;
    else
        top = nwcm(i,1);
    end
    
    if (nwcm(i,2)+border_b) < size(image,1)
        bottom = nwcm(i,2)+border_b;
    else
        bottom = nwcm(i,2);
    end
        
    imwrite(image(top:bottom,:,:),filenameOut);
end
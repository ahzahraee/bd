%These parameters depend on images
whthreshold = 10; %default 20 / 80 for sylvain first pass
ymin = 5; %width of white clusters to neglect (such as space between lines of text), default 3
hmin = 50; %min width of a non white cluster (to ignore e.g. page numbers), default 50
border = 5; %%border to add around frame in pixels, default 5
inputimageformat = '*.jpg';
outputimageformat = '.jpg';
xmin = ymin;
wmin = hmin;

%read image
filePath = uigetdir; %input files dir
pause(1)
outPath = uigetdir; %output files dir

imagefiles=dir(fullfile(filePath,inputimageformat)); %struct array of input files
npages = length(imagefiles); %number of pages


for im = 1:npages
    
filenameIn = imagefiles(im).name;    %char array
fullFilename = fullfile(filePath,filenameIn); %string

a = imread(fullFilename);

sz = size(a);
h = size(a,1);
w = size(a,2);

wc = whiteCols(a,w,h,whthreshold);

nwc = 0; %number of non white clusters
col0 = 1;
nre = 0; %index of rising edge (row becomes non white)
nfe = 0; %index of falling edge (next row becomes white)
 
 while (nre ~= -1 && nfe ~= h && col0<w)
     nre = nextRiseEdge(wc, col0, w);
     if (nre == -1) %reached end of page with no new rising edge
         break;
     end
     nfe = nextFallEdge(wc, nre, w);

%      if (nre>row0 && nfe>nre)
      nwc = nwc + 1;
      nonwc(nwc,:) = [nre,nfe];
        
%      end

     col0 = nfe+1;
 end
 
 if (nwc~=0) %white page
  
    mc = mergeNonWhiteClusters(nonwc, xmin, nwc, wmin);
    nout = size(mc,1); %number of output frames
    
 else
     nout = 1; %white page is 1 output frame
     mc = [1 w];
 end
 
 exportSingles(a,mc,nout,border,outPath,filenameIn,outputimageformat); %ltr
 %exportSinglesRTL(a,mc,nout,border,outPath,filenameIn,outputimageformat); %rtl

  
 clearvars nonwc
 
end
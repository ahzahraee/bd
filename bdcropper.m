%bdcropper_horizontal
%this program cuts pages to horizontal frames
%clear;

%These parameters depend on images
whthreshold = 20; %default 20
ymin = 2; %width of white clusters to neglect (such as space between lines of text), default 6
hmin = 80; %min height of a non white cluster (to ignore e.g. page numbers), default 120
border_top = 10; %%border to add top and bottom of each frame in pixels, default 10
border_bottom = 10;
inputimageformat = '*.jpg';
outputimageformat = '.jpg';


%read image
filePath = uigetdir %input files dir
pause(1)
outPath = uigetdir %output files dir

imagefiles=dir(fullfile(filePath,inputimageformat)); %struct array of input files
npages = length(imagefiles) %number of pages


for im = 1:npages

filenameIn = imagefiles(im).name;    %char array
fullFilename = fullfile(filePath,filenameIn); %string

a = imread(fullFilename);

sz = size(a);
h = size(a,1);
w = size(a,2);

%find white rows, return them in a vector of 0,1
wr = whiteRows(a,w,h,whthreshold);

%find clusers of white rows:
    %find rising edge i.e start of white cluster, gets starting row as an
        %argument, each time getting previous falling edge+1

     %find falling edge i.e. end of cluster, gets last rising edge+1 as an
        %argument
    %save clusters in a 2 column matrix, columns are start and end of clusters

 nwc = 0; %number of non white clusters
 row0 = 1;
 nre = 0; %number of rising edge (row becomes non white)
 nfe = 0; %number of falling edge (next row becomes white)

 while (nre ~= -1 && nfe ~= h)
     nre = nextRiseEdge(wr, row0, h);
     if (nre == -1) %reached end of page with no new rising edge
         break;
     end
     nfe = nextFallEdge(wr, nre, h);

%      if (nre>row0 && nfe>nre)
      nwc = nwc + 1;
      nonwc(nwc,:) = [nre,nfe];

%      end

     row0 = nfe+1;
 end

 if (nwc~=0) %white page

%merge neighbouring clusters with small distance
    %go over matrix of clusters, if the distance between end of a cluster
    %and start of next one is smaller than ymin, then merge them into one
    %cluster, save into new matrix of clusters

    mc = mergeNonWhiteClusters(nonwc, ymin, nwc, hmin);
    nout = size(mc,1); %number of output frames

 else
     nout = 1; %white page is 1 output frame
     mc = [1 h];
 end

    %export non white clusters to image frames

  exportFrames(a,mc,nout,border_top,border_bottom,outPath,filenameIn,outputimageformat);

  clearvars nonwc

end


%framecutter();

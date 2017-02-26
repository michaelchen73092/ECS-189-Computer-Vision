% 1. initialize BOW matrix
addpath('./provided_code/');
framesdir = '/usr/local/189data/frames/';
siftdir = '/usr/local/189data/sift/';
fnames = dir([siftdir '/*.mat']);
load('kMeans.mat', 'kMeans');
K = size(kMeans,1);
load('BOW.mat');
Framenumber=2121;
threshold = .15; %no threshold
Mdis = 5; %# image can display

% for handin without BOW matrix ( without normalized)
BOW=zeros(size(fnames,1),K);
binranges = 1:K; 
% Calculate BOW
for i=1:length(fnames)
    % load that file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    numfeats = size(descriptors,1);
    if ( numfeats ~=0)
       tempkMeanstable=dist2(kMeans,descriptors);
       [M,index]=min(tempkMeanstable); %some of them M is large 
       bincounts= histc(index,binranges);
       BOW(i,:) = bincounts;     
    end
end
for i = 1 : length(fnames)
    BOWV(i,:)=BOW(i,:)/norm(BOW(i,:)); %normalized Bag of words of each frame
end

% 2. Calculate BOW with tf-idf
% Build tf-idf weighting
ni = zeros(K,1);
for i = 1 : length(fnames)
   for j = 1 : K
       if BOW(i,j) >0
           ni(j) = ni(j) + 1;
       end    
   end    
end
for i = 1 : K
    ni(i) = log(length(fnames)/ni(i));
    if ni(i) == Inf
        ni(i) = 0;
    end    
end    
% Original way to set ni
%for  i=1:K
%   ni(i) = sum(BOW(:,i));
%   ni(i) = log(length(fnames)/ni(i));
%   if ni(i) == Inf 
%      ni(i) = 0;
%   % set most frequency to zero   
%   %elseif ni(i) < 0
%   %    ni(i) = 0;
%   end    
%end

for i=1:length(fnames)
   nd = sum(BOW(i,:));
   for j = 1 : K
    BOW(i,j) = BOW(i,j) * ni(j) / nd;
   end
end

for i = 1 : length(fnames)
    BOWV(i,:)=BOW(i,:)/norm(BOW(i,:)); %normalized Bag of words of each frame
end


% 3. selected region frames
% load that file
binranges = 1:K; 

fname = [siftdir '/' fnames(Framenumber).name];
load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
descriptorsSR=descriptors;
imname = [framesdir '/' imname]; % add the full path
im = imread(imname);

imshow(im);
oninds = selectRegion(im, positions);    
%calculate BOW of selected region
tempkMeanstable=dist2(kMeans,descriptors(oninds,:));
[M,index]=min(tempkMeanstable); %set every selected feature as a visual work: index 
bincounts= histc(index,binranges);
SRBOW = bincounts;  %selected region bag of words    

%SRBOW also need to do rf-idf weighting
nd = sum(SRBOW);
for j = 1 : K
    SRBOW(j) = SRBOW(j) * ni(j) / nd;
end
%normalized SRBOW
SRBOW=SRBOW/norm(SRBOW);

% 3. Find simular frames
% METHOD 1: Make selected region a BOW, and compare it with other 6612 frames.  
Dot1500 = zeros(length(fnames),1); 
for i = 1 : length(fnames) 
    Dot1500(i)=dot(SRBOW,BOWV(i,:));
end
Cosine_index = zeros(5,1);
Dot1500(Framenumber)=0; %set frame of selected region to zero
M = zeros(Mdis,1);
for i = 1 : Mdis
   [M(i),Cosine_index(i)] = max(Dot1500);
   Dot1500(Cosine_index(i))=0;
end

% 4. Print top five similar frames
figure
% read in the associated image
subplot(2,3,1);
imshow(im);
title(['Original Frame #',num2str(Framenumber)]);


for i = 1 : Mdis
    fname = [siftdir '/' fnames(Cosine_index(i)).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    imname = [framesdir '/' imname];
    im = imread(imname);
    
    %%%%%%%%%%%%%%%%%%
    % compute nearest raw SIFT descriptors
    newoninds = zeros(size(oninds,1),1);
    tempdistfortwo = dist2(descriptorsSR(oninds,:), descriptors);
    for on = 1 : size(oninds,1) 
       %find the two smallest dist features in second image
       [M1, row1] = min(tempdistfortwo(on,:));
       tempdistfortwo(on,row1)=10;
       [M2, row2] = min(tempdistfortwo(on,:));
       % if mached then store index in newoninds
       if ( (M1 < threshold) && (row1/row2 < 0.7) )
          newoninds(on)= row1;
       end
    end  
    % get rid of zero that for dummy space for initial
    newoninds=sort(newoninds,'descend');
    for  on = 1 : size(oninds,1)
       if (newoninds(on) == 0) 
          break; 
       end
    end
    %resize the vector to each of elements have a nonzero value
    if(newoninds(on) == 0)
    newoninds1=newoninds(1:on-1,1);
    else 
    newoninds1=newoninds(1:on,1);
    end
    %%%%%%%%%%%%%%%%%%
    
    subplot(2,3,i+1);
    imshow(im) 
    displaySIFTPatches(positions(newoninds1,:), scales(newoninds1), orients(newoninds1), im); 
    title([num2str(i),' simular frame:',num2str(Cosine_index(i))]);
end

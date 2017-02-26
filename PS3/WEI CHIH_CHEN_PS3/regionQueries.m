% 1. load BOW matrix
load('BOW.mat');
load('kMeans.mat', 'kMeans','membership');
addpath('./provided_code/');
framesdir = '/usr/local/189data/frames/';
siftdir = '/usr/local/189data/sift/';
fnames = dir([siftdir '/*.mat']);

% 2. selected region frames
% load that file
Framenumber=1536;
K=size(kMeans,1);
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
M = zeros(5,1);
for i = 1 : 5
   [M(i),Cosine_index(i)] = max(Dot1500);
   Dot1500(Cosine_index(i))=0;
end

% METHOD 2: Used inverted file index, find top five frames by hightest counts
% get inverted file index: Wordsindex
%N = size(membership,2) / length(fnames);
%Wordsindex = zeros(K,1) + 1; 
% Invertedfile is (words K, ith frame)
%Invertedfile = zeros(K, length(fnames));
%frameindex = 0;
%framenumber = 1;
%for ind = 1 : size(membership,2)
%    frameindex = frameindex + 1;
%    Invertedfile(membership(ind), Wordsindex(membership(ind))) = framenumber;
%    Wordsindex(membership(ind)) = Wordsindex(membership(ind)) + 1;
%    % beware order of frameindex is matter
%    if (frameindex == N)
%        framenumber = framenumber + 1;
%        frameindex = 0;
%    end
%end
%%use index from 2. step which are visual words of every features in selected region
%visualwordcount = zeros(length(fnames),1);
%for a = 1 : length(index)
%    for j = 1 : length(fnames)
%        if (Invertedfile(index(a),j) ~= 0)
%            visualwordcount(Invertedfile(index(a),j)) = visualwordcount(Invertedfile(index(a),j)) + 1;
%        end
%    end    
%end
%visualwordcount(:,2)=[1:1:length(fnames)];
%visualwordcount1 = sortrows(visualwordcount,1);
%for i = 1 : 5
%   Cosine_index(i) = visualwordcount1(length(fnames)-i+1);
%end


% 4. Print top five similar frames
figure
% read in the associated image
subplot(2,3,1);
imshow(im);
title(['Original Frame #',num2str(Framenumber)]);
threshold = .1; %no threshold

for i = 1 : 5
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

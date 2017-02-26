load('kMeans.mat', 'kMeans');
addpath('./provided_code/');

framesdir = '/usr/local/189data/frames/';
siftdir = '/usr/local/189data/sift/';
% 1. initialize BOW matrix
fnames = dir([siftdir '/*.mat']);
K = size(kMeans,1);
BOW=zeros(size(fnames,1),K);
binranges = 1:K; 
% 2. Calculate BOW
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
save('BOW.mat','BOW','BOWV');

% 3. Find simular frame
Framenumber=795;
Dot1500 = zeros(length(fnames),1); 
for i = 1 : length(fnames) 
    Dot1500(i)=dot(BOWV(Framenumber,:),BOWV(i,:));
end

Cosine_index = zeros(5,1);
Dot1500(Framenumber)=0;
for i = 1 : 5
   [M,Cosine_index(i)] = max(Dot1500);
   Dot1500(Cosine_index(i))=0;
end

figure
fname = [siftdir '/' fnames(Framenumber).name];
load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
numfeats = size(descriptors,1);  
% read in the associated image
imname = [framesdir '/' imname]; % add the full path
im = imread(imname);
subplot(2,3,1);
imshow(im);
title(['Original Frame #',num2str(Framenumber)]);

for i = 1 : 5
    fname = [siftdir '/' fnames(Cosine_index(i)).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    imname = [framesdir '/' imname];
    im = imread(imname);
    subplot(2,3,i+1);
    imshow(im) 
    title([num2str(i),' simular frame:',num2str(Cosine_index(i))]);
end

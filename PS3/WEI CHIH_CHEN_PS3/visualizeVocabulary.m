% 0. Initial data
addpath('./provided_code/');

framesdir = '/usr/local/189data/frames/';
siftdir = '/usr/local/189data/sift/';
fnames = dir([siftdir '/*.mat']);

% 1. select SIFT descriptors
N = 100;  % to visualize a sparser set of the features
K = 1500;
total = N*length(fnames);
alldescriptors = zeros(total,128);
alldescriptorsinfo = zeros(2,total);    
% 2. Loop through all the data files for features in frames
for i=1:length(fnames)
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');   
    numfeats = size(descriptors,1);
    randinds = randperm(numfeats);
    alldescriptors(1+(i-1)*min([N,numfeats]) : i*min([N,numfeats]) , :) = descriptors(randinds(1:min([N,numfeats])),:);
    alldescriptorsinfo(1,1+(i-1)*min([N,numfeats]) : i*min([N,numfeats]) ) = i; %frames
    alldescriptorsinfo(2,1+(i-1)*min([N,numfeats]) : i*min([N,numfeats]) ) = randinds(1:min([N,numfeats])); % index of feature in that frame
end
alldescriptors = alldescriptors';

% 3. kmeans for warks
[membership,kMeans,rms] = kmeansML(K,alldescriptors);
save('kMeans.mat','membership','kMeans');
membership = membership';
kMeans = kMeans';   
% 4. find visual words
%%calculate all cluseter visual word and select least distance 
%VM first dimention is K
%VM second dimention is 3
%VM third dimention is maximum number of any cluster
VW = zeros(K,3, ceil (3 * size(alldescriptors,2) / K) );
for i = 1 : K
    VW(i,:,:) = i; 
end
%VW second dimention:
%VW(:,1,:) row1: frame
%VW(:,2,:) row2: index of feature2
%VW(:,3,:) row3: dist 
Jarr = zeros(K,1)+1;  
for i = 1 : size(alldescriptors,2)  
    for j = 1 : K 
       if (membership(i) == j )
          VW(j,1,Jarr(j)) = alldescriptorsinfo(1,i);
          VW(j,2,Jarr(j)) = alldescriptorsinfo(2,i);
          VW(j,3,Jarr(j)) = dist2(alldescriptors(:,i)',kMeans(j,:));
           Jarr(j) = Jarr(j)+1 ;    
       else     
       end 
    end
end
%sort K VM clusters by second dimention, third row (distance) order
%In this one we should cut dummy 0 after every clusters
for i = 1 : K
   a = VW(i,:, 1 : Jarr(i)-1);
   a = squeeze(a);
   a = a';
   a=sortrows(a,3);
   a=a';
   d=zeros(3, size(VW,3) - size(a,2));
   a=cat(2,a,d);
   b=a;
   c = cat(3,a,b);
   c = permute(c, [3 1 2]);
   VW(i,:,:) = c(1,:,:);
end

%find two virtual worlds: first is the smallest distance around that
%cluseter center, second is the 40th smallest distance around that cluster
%V1 and V2 are the selected virtural words
copVM= VW(:,:,1);
for i = 1 : K
    if (copVM(i,3) ==0 )
       copVM(i,3) = 10;
    end   
end    

[M,V1]=min(copVM(:,3));
V2=V1;
for i = 1 : 40
copVM(V2,3)=10;
[M,V2]=min(copVM(:,3));
end

% 5. show two visual words by getPatchFromSIFTParameters
figure
for i = 1 : 25
    fname = [siftdir '/' fnames(VW(V1,1,i)).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    imname = [framesdir '/' imname];
    im = imread(imname);
    im = rgb2gray(im);
    [patch] = getPatchFromSIFTParameters( positions(VW(V1,2,i),:), scales(VW(V1,2,i)), orients(VW(V1,2,i)), im);
    subplot(2,13,i);
    imshow(patch)
end

figure
for i = 1 : 25
    fname = [siftdir '/' fnames(VW(V2,1,i)).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    imname = [framesdir '/' imname];
    im = imread(imname);
    im = rgb2gray(im);
    [patch] = getPatchFromSIFTParameters( positions(VW(V2,2,i),:), scales(VW(V2,2,i)), orients(VW(V2,2,i)), im);
    subplot(2,13,i);
    imshow(patch)
end

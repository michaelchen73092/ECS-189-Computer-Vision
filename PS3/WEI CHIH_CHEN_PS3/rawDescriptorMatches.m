%set parameter
addpath('./provided_code/');
threshold = .3; %no threshold
% load that file
load('twoFrameData.mat')
numfeats2 = size(descriptors2,1);

imshow(im1);
oninds = selectRegion(im1, positions1);    
newoninds = zeros(size(oninds,1),1);
tempdistfortwo = zeros(numfeats2,1);

% compute nearest raw SIFT descriptors
for i = 1 : size(oninds,1) 
   for j = 1 : numfeats2
       tempdistfortwo(j) = dist2(descriptors1(oninds(i),:), descriptors2(j,:));
   end
   %find the two smallest dist features in second image
   [M1, row1] = min(tempdistfortwo);
   tempdistfortwo(row1)=10;
   [M2, row2] = min(tempdistfortwo);
   % if mached then store index in newoninds
   if ( (M1 < threshold) && (row1/row2 < 0.7) )
      newoninds(i)= row1;
   end
end  
% get rid of zero that for dummy space for initial
newoninds=sort(newoninds,'descend');
for  i = 1 : size(oninds,1)
   if (newoninds(i) == 0) 
      break; 
   end
end
%resize the vector to each of elements have a nonzero value
if(newoninds(i) == 0)
newoninds1=newoninds(1:i-1,1);
else 
newoninds1=newoninds(1:i,1);
end

% display only those features
imshow(im2);
displaySIFTPatches(positions2(newoninds1,:), scales2(newoninds1), orients2(newoninds1), im2); 
title('showing features within region of interest in im1, and all feature in im2');
    


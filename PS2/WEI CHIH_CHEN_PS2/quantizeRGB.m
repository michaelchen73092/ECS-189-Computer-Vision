function [outputImg,meanColors] = quantizeRGB(origImg,k)
origImg=im2double(origImg);
X=reshape(origImg,size(origImg,1)*size(origImg,2),3);
idx=kmeans(X,k);
X=reshape(idx,size(origImg,1),size(origImg,2));
meanColors=zeros(k,3);
outputImg=zeros(size(origImg,1),size(origImg,2),3);

%get meanColors
for a=1 : k 
    count=0;
    for i=1 : size(origImg,1)
        for j=1 : size(origImg,2)
            if(X(i,j)==a) 
                meanColors(a,:)=meanColors(a,:)+reshape(origImg(i,j,:),1,3); %reshape origImg as vector(1,3)
                count=count+1;
            else 
            end  %end if  
        end    
    end
    meanColors(a,:)=meanColors(a,:)/count;
end
% assign meanColors to outputImg
for a=1 : k 
    for i=1 : size(origImg,1)
        for j=1 : size(origImg,2)
            if(X(i,j)==a) 
                outputImg(i,j,:)=meanColors(a,:);
            else 
            end  %end if  
        end    
    end
end
outputImg=im2uint8(outputImg);
%figure     
%imagesc(outputImg); 
end %function end
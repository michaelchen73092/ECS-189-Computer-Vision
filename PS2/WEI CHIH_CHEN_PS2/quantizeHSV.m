function [outputImg,meanHues] = quantizeHSV(origImg,k)
origImg=rgb2hsv(origImg);
X=reshape(origImg,size(origImg,1)*size(origImg,2),3);
X=X(:,1);
idx=kmeans(X,k);
X=reshape(idx,size(origImg,1),size(origImg,2));
meanHues=zeros(k,1);
outputImg=origImg;
Hue=origImg(:,:,1);
%get meanColors
for a=1 : k 
    count=0;    
    for i=1 : size(origImg,1)
        for j=1 : size(origImg,2)
            if(X(i,j)==a) 
                meanHues(a,1)=meanHues(a,1)+Hue(i,j);
                count=count+1;
            else 
            end  %end if  
        end    
    end
    meanHues(a,1)=meanHues(a,1)/count;
end
% assign meanColors to outputImg
for a=1 : k 
    for i=1 : size(origImg,1)
        for j=1 : size(origImg,2)
            if(X(i,j)==a) 
                outputImg(i,j,1)=meanHues(a,1);
            else 
            end  %end if  
        end    
    end
end
outputImg=hsv2rgb(outputImg);
outputImg=im2uint8(outputImg);
end %function end
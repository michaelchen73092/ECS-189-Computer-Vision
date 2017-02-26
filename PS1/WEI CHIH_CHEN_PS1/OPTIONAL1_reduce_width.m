function reducedColorImage = OPTIONAL1_reduce_width(im,cumulativeEnergyMap,xleft,yindex)
reducedColorImage=zeros(size(im,1),size(im,2)-1,3);
verticalSeam = OPTIONAL1_find_optimal_vertical_seam(cumulativeEnergyMap,xleft,yindex);

     for a=1 : size(im,1)
         for b=1 : verticalSeam(a)-1
             reducedColorImage(a,b,:)=im(a,b,:);
         end
         for b=verticalSeam(a) : size(im,2)-1
             reducedColorImage(a,b,:)=im(a,b+1,:);            
         end         
     end
reducedColorImage=uint8(reducedColorImage);
end

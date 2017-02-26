function [reducedColorImage,reduceEnergyImage] = reduce_height(im, energyImage)
reducedColorImage=zeros(size(im,1)-1,size(im,2),3);
reduceEnergyImage=zeros(size(im,1)-1,size(im,2));
cumulativeEnergyMap = cumulative_minimum_energy_map(energyImage,'HORIZONTAL');
horizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMap);

     for b=1 : size(im,2)
         for a=1 : horizontalSeam(b)-1
             reducedColorImage(a,b,:)=im(a,b,:);
             reduceEnergyImage(a,b)=energyImage(a,b);
         end
         for a=horizontalSeam(b) : size(im,1)-1
             reducedColorImage(a,b,:)=im(a+1,b,:);
             reduceEnergyImage(a,b)=energyImage(a+1,b);             
         end         
     end
reducedColorImage=uint8(reducedColorImage);     
end

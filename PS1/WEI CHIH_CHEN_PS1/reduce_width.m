function [reducedColorImage,reduceEnergyImage] = reduce_width(im, energyImage)
reducedColorImage=zeros(size(im,1),size(im,2)-1,3);
reduceEnergyImage=zeros(size(im,1),size(im,2)-1);
cumulativeEnergyMap = cumulative_minimum_energy_map(energyImage,'VERTICAL');
verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap);

     for a=1 : size(im,1)
         for b=1 : verticalSeam(a)-1
             reducedColorImage(a,b,:)=im(a,b,:);
             reduceEnergyImage(a,b)=energyImage(a,b);
         end
         for b=verticalSeam(a) : size(im,2)-1
             reducedColorImage(a,b,:)=im(a,b+1,:);
             reduceEnergyImage(a,b)=energyImage(a,b+1);             
         end         
     end
reducedColorImage=uint8(reducedColorImage);
end

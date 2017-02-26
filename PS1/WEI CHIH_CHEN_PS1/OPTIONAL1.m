im1=imread('IMG5.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%IM1

energyImage = energy_image(im1);
cumulativeEnergyMap = cumulative_minimum_energy_map(energyImage,'VERTICAL'); %%notice bug happened when chossing wrong direction

figure;
imshow(im1);
[x,y] = ginput(4);

[xleft,index]=min(x);
yindex=y(index);
yindex=round(yindex);
xright=max(x);
reducedColorImage=im1;

   for t=xleft:xright
       reducedColorImage = OPTIONAL1_reduce_width(reducedColorImage,cumulativeEnergyMap,xleft,yindex);
   end
   
imwrite(reducedColorImage,'outputReduceObjectIMG5.png');
       
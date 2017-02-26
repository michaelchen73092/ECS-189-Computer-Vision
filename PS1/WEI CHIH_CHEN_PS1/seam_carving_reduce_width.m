im=imread('inputSeamCarvingPrague.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%first question
%im=imread('inputSeamCarvingMall.jpg');
energyImage = energy_image(im);
reducedColorImage=im;
reduceEnergyImage=energyImage;

for i=1:100
    [reducedColorImage,reduceEnergyImage] = reduce_width(reducedColorImage, reduceEnergyImage);
end

imwrite(reducedColorImage,'outputReduceWidthPrague.png');
%imwrite(reducedColorImage,'outputReduceWidthMall.png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%third question
%figure     
%imagesc(energyImage); 
%colormap gray;%
%
%cumulativeEnergyMaph = cumulative_minimum_energy_map(energyImage,'HORIZONTAL');
%cumulativeEnergyMapw = cumulative_minimum_energy_map(energyImage,'VERTICAL');
%figure     
%imagesc(cumulativeEnergyMaph); 
%colormap gray;
%
%figure     
%imagesc(cumulativeEnergyMapw); 
%colormap gray;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%fourth question
%cumulativeEnergyMaph = cumulative_minimum_energy_map(energyImage,'HORIZONTAL');
%horizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMaph);
%displayseam1 = display_seam(im,horizontalSeam,'HORIZONTAL');
%figure     
%imagesc(displayseam1); 
%
%cumulativeEnergyMapw = cumulative_minimum_energy_map(energyImage,'VERTICAL');
%verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMapw);
%displayseam2 = display_seam(im,verticalSeam,'VERTICAL');
%figure     
%imagesc(displayseam2); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%second question

%im=imread('inputSeamCarvingPrague.jpg');
im=imread('inputSeamCarvingMall.jpg');
energyImage = energy_image(im);
reducedColorImage=im;
reduceEnergyImage=energyImage;

for i=1:100
    [reducedColorImage,reduceEnergyImage] = reduce_height(reducedColorImage, reduceEnergyImage);
end

%imwrite(reducedColorImage,'outputReduceHeightPrague.png');
imwrite(reducedColorImage,'outputReduceHeightMall.png');
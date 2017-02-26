im1=imread('IMG1.jpg');
im2=imread('IMG2.jpg');
im3=imread('IMG3.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%IM1
energyImage = energy_image(im1);
reducedColorImage=im1;
reduceEnergyImage=energyImage;

for i=1:200
    [reducedColorImage,reduceEnergyImage] = reduce_width(reducedColorImage, reduceEnergyImage);
    [reducedColorImage,reduceEnergyImage] = reduce_height(reducedColorImage, reduceEnergyImage);
end

figure;
subplot(2,2,1);
imshow(im1);
title('a) Original car (497X663)');

im1r = imresize(im1, [297 463]);
subplot(2,2,2);
imshow(im1r);
title('b) Matlab imresize (297X463)');

subplot(2,2,3);
imshow(reducedColorImage);
title('c) Seam resize (297X463)');



%%%%%%%%%IM2
energyImage = energy_image(im2);
reducedColorImage=im2;
reduceEnergyImage=energyImage;

for i=1:200
    [reducedColorImage,reduceEnergyImage] = reduce_width(reducedColorImage, reduceEnergyImage);
end

figure;
subplot(2,2,1);
imshow(im2);
title('a) Original machu picchu (496X884)');

im2r = imresize(im2, [496 684]);
subplot(2,2,2);
imshow(im2r);
title('b) Matlab imresize (496X684)');

subplot(2,2,3);
imshow(reducedColorImage);
title('c) Seam resize (496X684)');

%%%%%%%%%IM3
energyImage = energy_image(im3);
reducedColorImage=im3;
reduceEnergyImage=energyImage;

%for i=1:200
%    [reducedColorImage,reduceEnergyImage] = reduce_width(reducedColorImage, reduceEnergyImage);
%end
for i=1:150
    [reducedColorImage,reduceEnergyImage] = reduce_height(reducedColorImage, reduceEnergyImage);
end

figure;
subplot(2,2,1);
imshow(im3);
title('a) Original Torii (450X674)');

im3r = imresize(im3, [300 674]);
subplot(2,2,2);
imshow(im3r);
title('b) Matlab imresize (300X674)');

subplot(2,2,3);
imshow(reducedColorImage);
title('c) Seam resize (300X674)');



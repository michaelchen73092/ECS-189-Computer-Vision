function energyImage = energy_image(im)

%im=imread('inputSeamCarvingPrague.jpg');
Pic=rgb2gray(im);
My=fspecial('sobel');
Mx=My.';
outimy=imfilter(double(Pic),My);
outimx=imfilter(double(Pic),Mx);
energyImage=(outimy.^2+outimx.^2).^(0.5);
%%%%show Image gradient picture%%%
%imagesc(energyImage);
%colormap gray;
end

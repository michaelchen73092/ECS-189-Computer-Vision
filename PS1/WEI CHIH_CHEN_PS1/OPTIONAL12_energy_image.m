function energyImage = OPTIONAL12_energy_image(im,xleft,xright,yup, ydown)

%im=imread('inputSeamCarvingPrague.jpg');
Pic=rgb2gray(im);
My=fspecial('sobel');
Mx=My.';
outimy=imfilter(double(Pic),My);
outimx=imfilter(double(Pic),Mx);
energyImage=(outimy.^2+outimx.^2).^(0.5);


for i= ydown : yup
    for j= xleft: xright
        energyImage(i,j)=0;
    end
end    

%%%%show Image gradient picture%%%
imagesc(energyImage);
colormap gray;
end

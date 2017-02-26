im1=imread('IMG5.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%IM1

figure;
imshow(im1);
[x,y] = ginput(4);
[xleft,index]=min(x);
[xright,indexr]=max(x);
[ydown,index]=min(y);
[yup,indexr]=max(y);

yup=yup + (yup-ydown)*0.9;
ydown=ydown - (yup-ydown)*0.9;
xleft=xleft - (xright-xleft)*0.2;
xright=xright + (xright-xleft)*0.2;

xleft=round(xleft);
xright=round(xright);
yup=round(yup);
ydown=round(ydown);


energyImage = OPTIONAL12_energy_image(im1,xleft,xright,yup, ydown);
reducedColorImage=im1;
reduceEnergyImage=energyImage;

for i=xleft:xright
    [reducedColorImage,reduceEnergyImage] = reduce_width(reducedColorImage, reduceEnergyImage);
end

imwrite(reducedColorImage,'outputReduceWidthIM5.png');


Pic=imread('IMG.jpg');
%%%%
% a) grayscale 
a=rgb2gray(Pic);
figure;
subplot(3,2,1);
imshow(a);
title('a) Grayscale image');

%b) negative image 
b=imcomplement(a);
subplot(3,2,2);
imshow(b);
title('b) Negative image');

%c) mirror image 
% http://www.mathworks.com/help/matlab/ref/flipdim.html?searchHighlight=flipdim
c=flip(Pic,2);
subplot(3,2,3);
imshow(c);
title('c) Mirror image');

%d) swap red and green color channels 
% http://www.quora.com/How-do-you-swap-the-color-of-pixels-in-MATLAB
d(:,:,1)=Pic(:,:,2);
d(:,:,2)=Pic(:,:,1);
d(:,:,3)=Pic(:,:,3);
subplot(3,2,4);
imshow(d);
title('d) Swap red and green color channels');

%e) average input color image with mirror image
e1=im2double(c);
e2=im2double(Pic);
e=(e1+e2)/2;
subplot(3,2,5);
imshow(e);
title('e) Average input color image with mirror image');

%f) add random value and clip value out of scope
sizeP=size(a);
f1=randi(256,sizeP(1),sizeP(2))-1;
f=a-uint8(f1);
subplot(3,2,6);
imshow(f);
title('f) Add random value and clip value out of scope');

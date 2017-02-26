%%(a)%%
origImg=imread('fish.jpg');
[outputImg1,meanColors] = quantizeRGB(origImg,5);
[outputImg2,meanColors] = quantizeRGB(origImg,25);
figure   
subplot(2,2,1);
imshow(origImg); 
title('Subplot 1:Original fish.jpg');
subplot(2,2,2);
imshow(outputImg1); 
title('Subplot 2:k=5 fish.jpg for RGB');
subplot(2,2,3);
imshow(outputImg2); 
title('Subplot 3:k=25 fish.jpg for RGB');

%%(b)%%
[outputImgb1,meanHues] = quantizeHSV(origImg,5);
[outputImgb2,meanHues] = quantizeHSV(origImg,25);
figure   
subplot(2,2,1);
imshow(origImg); 
title('Subplot 1:Original fish.jpg');
subplot(2,2,2);
imshow(outputImgb1); 
title('Subplot 2:k=5 fish.jpg for HSV');
subplot(2,2,3);
imshow(outputImgb2); 
title('Subplot 3:k=25 fish.jpg for HSV');

%%(c)%%
[errora1] = computeQuantizationError(origImg,outputImg1); %k=5 RGB
[errora2] = computeQuantizationError(origImg,outputImg2); %k=25 RGB
[errorb1] = computeQuantizationError(origImg,outputImgb1); %k=5 HSV
[errorb2] = computeQuantizationError(origImg,outputImgb2); %k=25 HSV

%%(d)%%
im=imread('fish.jpg');
[histEqual5,histClustered5] = getHueHists(im,5);
%separate execute with k=5 and k=25
[histEqual25,histClustered25] = getHueHists(im,25);




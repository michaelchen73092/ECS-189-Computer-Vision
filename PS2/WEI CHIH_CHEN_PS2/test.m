%%%test%%%
%%(a)%%
k=3;
origImg=imread('IMG1.JPG');
[outputImg,meanColors] = quantizeRGB(origImg,k);
figure     
imagesc(outputImg); 
%%(b)%%
k=1;
origImg=imread('IMG1.JPG');
[outputImg,meanHues] = quantizeHSV(origImg,k);
figure     
imagesc(outputImg); 
%%(c)%%
[error] = computeQuantizationError(origImg,outputImg);
%%(d)%%
k=5;
im=imread('IMG1.JPG');
[histEqual,histClustered] = getHueHists(im,k);

%%2%%
%%(a)%%
im=imread('egg.jpg');
%figure
%imshow('girl.jpg');
%impixelinfo;

useGradient=0;
radius=8;
[centers0] = detectCircles(im, radius, 0);
[centers1] = detectCircles(im, radius, 1);
%%%plot circle
figure   
subplot(1,2,1);
imshow(im)
for i=1:size(centers0,1)
th = 0:pi/50:2*pi;
xunit0 = radius * cos(th) + centers0(i,2);
yunit0 = radius * sin(th) + centers0(i,1);
hold on
plot(xunit0, yunit0,'B','LineWidth',2);
end
title('Subplot 3:iris detection with useGradient=0, threthod =0.975*max');

subplot(1,2,2);
imshow(im)
for i=1:size(centers1,1)
th = 0:pi/50:2*pi;
xunit1 = radius * cos(th) + centers1(i,2);
yunit1 = radius * sin(th) + centers1(i,1);
hold on
plot(xunit1, yunit1,'B','LineWidth',2);
end
title('Subplot 2:iris detection with useGradient=1, radius=7');





%%(d)%%

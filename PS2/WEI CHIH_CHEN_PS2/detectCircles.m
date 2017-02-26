function [centers] = detectCircles(im, radius, useGradient)
%im1=imread('egg.jpg');
%useGradient=1;
%radius=8;
im=rgb2gray(im);
imedge= edge(im,'Canny');
HoughSpace=zeros(size(im,1)+2*radius,size(im,2)+2*radius);
%%tuning parameter
binsize=15;
thresholdvalue=0.9;
%%Transfer to HoughSpace
if useGradient ==0
for i=1:size(im,1)
    for j=1:size(im,2)
        if imedge(i,j)==1
            for theta=1:360
                a=radius+round(j-radius*cos(theta*2*pi/360));
                b=radius+round(i+radius*sin(theta*2*pi/360));
                HoughSpace(b,a) = HoughSpace(b,a)+1;
            end %% end for theta  
        end %%end if statement
    end    
end %end for
elseif useGradient ==1
       [Gx, Gy] = imgradientxy(im);
       [Gmag, Gdir] = imgradient(Gx, Gy);
for i=1:size(im,1)
    for j=1:size(im,2)
        for theta=Gdir(i,j)-45:Gdir(i,j)+45
                a=radius+floor(j-radius*cos(theta*2*pi/360));
                b=radius+floor(i+radius*sin(theta*2*pi/360));
                HoughSpace(b,a) = HoughSpace(b,a)+1;
        end        
    end    
end %end for
%figure, imshow(Gmag, []), title('Gradient magnitude')
%figure, imshow(Gdir, []), title('Gradient direction')
%figure, imshow(Gx, []), title('Directional gradient: X axis')
%figure, imshow(Gy, []), title('Directional gradient: Y axis')     
end %end elseif
figure
%imshow(mat2gray(HoughSpace));
imagesc(HoughSpace);
title('HoughSpace with usdGradient=1')

%%Voting  
a=floor(size(HoughSpace,1)/binsize);
b=floor(size(HoughSpace,2)/binsize);
accumulatorarray=zeros(a,b);
for i=1:a
    for j=1:b
            A=HoughSpace(1+((i-1)*binsize):i*binsize,1+((j-1)*binsize):j*binsize);
            accumulatorarray(i,j)=max(max(A));      
    end    
end
[row,col]=find(accumulatorarray>thresholdvalue*max(max(accumulatorarray)));  %%find voting result that larger 0.9*max

%%trace back to original circle center 
centers=zeros(size(row,1),2);
for i=1 : size(row,1)
   A=HoughSpace(1+((row(i,1)-1)*binsize):row(i,1)*binsize,1+((col(i,1)-1)*binsize):col(i,1)*binsize); 
   [M,I] = max(A(:));
   [I_row, I_col] = ind2sub(size(A),I);   
   centers(i,1)=(row(i,1)-1)*binsize+I_row-radius; 
   centers(i,2)=(col(i,1)-1)*binsize+I_col-radius;     
end
%figure   
%imshow(im1)
%for i=1:size(centers,1)
%th = 0:pi/50:2*pi;
%xunit0 = radius * cos(th) + centers(i,2);
%yunit0 = radius * sin(th) + centers(i,1);
%hold on
%plot(xunit0, yunit0,'R','LineWidth',2);
%end
%title('Subplot 2:egg.jpg with bin size=5 threshold =0.95*max value');    
end %function end
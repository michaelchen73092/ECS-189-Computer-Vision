load( 'PS0_A.mat');
B=sort(A(:),'descend');
figure
plot(B)

%b
h=histogram(B,20);
%c
Z=A(51:100,1:50);
imshow(Z);
%d
W=A-mean2(A);
imshow(W)
%e
Y=zeros(100,100,3); %initial RGB image with zero
%[r,c]=find(A>= mean2(A));
%for i=1:1:length(r)
%    Y(r(i),c(i),2)=255;
%end
I=find(A>= mean2(A));
Y(I)=255;
Y(:,:,2)=Y(:,:,1);
Y(:,:,1)=Y(:,:,3);
figure
imagesc(Y)


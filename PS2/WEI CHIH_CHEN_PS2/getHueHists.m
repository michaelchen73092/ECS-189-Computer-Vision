function [histEqual,histClustered] = getHueHists(im,k)
  %im=imread('fish.jpg');
  %k=25;
  %histEqual
  im=rgb2hsv(im);
  im=reshape(im,size(im,1)*size(im,2),3);
  im=im(:,1);
  
  histEqual=histogram(im,k);
  
  %histClustered
  [idx,c]=kmeans(im,k);
  idx(:,2)=im;
  csort=sort(c);
  csort(:,2)=zeros(k,1);
  imcluster=sort(idx,1);
  for j=1:size(imcluster,1)
      for i=1:k
      if(imcluster(j,1)==i) 
          %imcluster(j,2)=csort(i,1);
          csort(i,2)=csort(i,2)+1;
      end    
      end
  end    
  %decide x-axis for cluster    
  cdim=csort(:,1);
  cdim(k+1)=1;
  histClustered=histogram(imcluster,cdim);
  
  figure
  subplot(1,2,1);
  histogram(im,k);
  title('Subplot 1:Histogram for histEqual');
  subplot(1,2,2);
  histogram(imcluster,cdim);
  title('Subplot 2:Histogram for histClustered');
end %function end
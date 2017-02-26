function displayseam = display_seam(im,seam,seamDirection)

if  strcmp(seamDirection, 'VERTICAL')
     for a=1 : size(im,1)
         im(a,seam(a),1)=255;
         im(a,seam(a),2)=0;
         im(a,seam(a),3)=0;
     end
else  
     for a=1 : size(im,2)
         im(seam(a),a,1)=255;
         im(seam(a),a,2)=0;
         im(seam(a),a,3)=0;    
     end    
 end    
displayseam=im;
end

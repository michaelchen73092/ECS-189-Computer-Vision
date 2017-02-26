function [error] = computeQuantizationError(origImg,quantizedImg)
origImg=int64(origImg);
quantizedImg=int64(quantizedImg);
error=0;
    for i=1 : size(origImg,1)
        for j=1 : size(origImg,2)
            error=error+(origImg(i,j,1)-quantizedImg(i,j,1))^2+(origImg(i,j,2)-quantizedImg(i,j,2))^2+(origImg(i,j,3)-quantizedImg(i,j,3))^2; 
        end    
    end
end %function end
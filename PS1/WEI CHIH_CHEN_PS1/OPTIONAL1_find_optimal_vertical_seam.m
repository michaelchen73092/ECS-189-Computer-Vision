function verticalSeam = OPTIONAL1_find_optimal_vertical_seam(cumulativeEnergyMap,xleft,yindex)


verticalSeam=zeros(1,size(cumulativeEnergyMap,1));
lastindex=xleft;
verticalSeam(yindex)=xleft;
  
 for k=yindex-1:-1:1 %%need :-1 between start and end to execute decrease  
    if lastindex-1==0
        A=[cumulativeEnergyMap(k,lastindex)  cumulativeEnergyMap(k,lastindex+1)];  
        [lastvalue,lindex]=min(A);
        verticalSeam(k)=lastindex+lindex-2;
        lastindex=lastindex+lindex-2;
    elseif (lastindex==size(cumulativeEnergyMap,2))    
        A=[cumulativeEnergyMap(k,lastindex-1)  cumulativeEnergyMap(k,lastindex)];
        [lastvalue,lindex]=min(A);
        verticalSeam(k)=lastindex+lindex-2;
        lastindex=lastindex+lindex-2;
    else       
        A=[cumulativeEnergyMap(k,lastindex-1)  cumulativeEnergyMap(k,lastindex)  cumulativeEnergyMap(k,lastindex+1)];
        [lastvalue,lindex]=min(A);
        verticalSeam(k)=lastindex+lindex-2;
        lastindex=lastindex+lindex-2;
    end %%end for if that decide whether meet boundary
 end %%end for loop   
lastindex=xleft;
     for i=yindex+1:size(cumulativeEnergyMap,1) %start from yindex+1 row
            if (lastindex-1==0)
                A=[cumulativeEnergyMap(i,lastindex) cumulativeEnergyMap(i,lastindex+1)];
                [lastvalue,lindex]=min(A);
                verticalSeam(i)=lastindex+lindex-2;
                lastindex=lastindex+lindex-2; 
            elseif (lastindex==size(cumulativeEnergyMap,2))
                A=[cumulativeEnergyMap(i,lastindex-1) cumulativeEnergyMap(i,lastindex)];
                [lastvalue,lindex]=min(A);
                verticalSeam(i)=lastindex+lindex-2;
                lastindex=lastindex+lindex-2; 
            else 
                A=[cumulativeEnergyMap(i,lastindex-1) cumulativeEnergyMap(i,lastindex) cumulativeEnergyMap(i,lastindex+1)];    
                [lastvalue,lindex]=min(A);
                verticalSeam(i)=lastindex+lindex-2;
                lastindex=lastindex+lindex-2; 
            end %end for if
     end %end for row loop
end

function horizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMap)

horizontalSeam=zeros(1,size(cumulativeEnergyMap,2));
[lastvalue,lastindex]=min(cumulativeEnergyMap(:,size(cumulativeEnergyMap,2)));
horizontalSeam(size(cumulativeEnergyMap,2))=lastindex;
  
 for k=size(cumulativeEnergyMap,2)-1:-1:1 %%need :-1 between start and end to execute decrease  
    if (lastindex-1==0)
        A=[cumulativeEnergyMap(lastindex,k)  cumulativeEnergyMap(lastindex+1,k)];
        [lastvalue,lindex]=min(A);
        horizontalSeam(k)=lastindex+lindex-2;
        lastindex=lastindex+lindex-2;           
    elseif (lastindex==size(cumulativeEnergyMap,1))    
        A=[cumulativeEnergyMap(lastindex-1,k)  cumulativeEnergyMap(lastindex,k)];
        [lastvalue,lindex]=min(A);
        horizontalSeam(k)=lastindex+lindex-2;
        lastindex=lastindex+lindex-2; 
    else       
        A=[cumulativeEnergyMap(lastindex-1,k)  cumulativeEnergyMap(lastindex,k)  cumulativeEnergyMap(lastindex+1,k)];
        [lastvalue,lindex]=min(A);
        horizontalSeam(k)=lastindex+lindex-2;
        lastindex=lastindex+lindex-2;
    end %%end for if that decide whether meet boundary
 end %%end for loop
     
end

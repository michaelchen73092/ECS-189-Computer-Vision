function verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap)

verticalSeam=zeros(1,size(cumulativeEnergyMap,1));
[lastvalue,lastindex]=min(cumulativeEnergyMap(size(cumulativeEnergyMap,1),:));
verticalSeam(size(cumulativeEnergyMap,1))=lastindex;
  
 for k=size(cumulativeEnergyMap,1)-1:-1:1 %%need :-1 between start and end to execute decrease  
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
end

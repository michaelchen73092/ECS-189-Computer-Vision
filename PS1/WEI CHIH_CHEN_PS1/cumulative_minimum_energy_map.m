function cumulativeEnergyMap = cumulative_minimum_energy_map(energyImage,seamDirection)

cumulativeEnergyMap=zeros(size(energyImage,1),size(energyImage,2));


if strcmp(seamDirection, 'VERTICAL')
    cumulativeEnergyMap(1,:)=energyImage(1,:);
    for i=2:size(energyImage,1) %start from second row
        for j=1:size(energyImage,2) 
            if (j-1==0)
                A=[cumulativeEnergyMap(i-1,j) cumulativeEnergyMap(i-1,j+1)];
                cumulativeEnergyMap(i,j)=energyImage(i,j)+min(A);
            elseif (j==size(energyImage,2))
                A=[cumulativeEnergyMap(i-1,j-1) cumulativeEnergyMap(i-1,j) ];
                cumulativeEnergyMap(i,j)=energyImage(i,j)+min(A);
            else 
                A=[cumulativeEnergyMap(i-1,j-1) cumulativeEnergyMap(i-1,j) cumulativeEnergyMap(i-1,j+1)];
                cumulativeEnergyMap(i,j)=energyImage(i,j)+min(A);                
            end %end for if
        end %end for colomn loop
    end %end for row loop
else    
    cumulativeEnergyMap(:,1)=energyImage(:,1);
    for j=2:size(energyImage,2) %start from second colomn
        for i=1:size(energyImage,1) 
            if (i-1==0)
                A=[cumulativeEnergyMap(i,j-1) cumulativeEnergyMap(i+1,j-1)];
                cumulativeEnergyMap(i,j)=energyImage(i,j)+min(A);
            elseif (i==size(energyImage,1))
                A=[cumulativeEnergyMap(i-1,j-1) cumulativeEnergyMap(i,j-1)];
                cumulativeEnergyMap(i,j)=energyImage(i,j)+min(A);
            else 
                A=[cumulativeEnergyMap(i-1,j-1) cumulativeEnergyMap(i,j-1) cumulativeEnergyMap(i+1,j-1)];
                cumulativeEnergyMap(i,j)=energyImage(i,j)+min(A);                
            end %end for if
        end %end for colomn loop
    end %end for row loop    
end 
end

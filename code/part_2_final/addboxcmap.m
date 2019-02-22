function [cmap] = addboxcmap(cmap,box,value,nx,ny)



    for jx=1:nx


        for iy=1:ny
                
                if(abs(iy-box(1,2)) < box(1,3)/2 & abs(jx-box(1,1)) < box(1,4)/2)
                    
                    cmap(iy,jx)=value;
                    
                end


        end

    end

end


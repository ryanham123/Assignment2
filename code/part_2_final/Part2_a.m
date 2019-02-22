
clear all
clc




global nx ny

setting=1;

setting=2;

for u=1
    

    nx=200*u;
    ny=100*u;

    cMap=ones(ny,nx);

    boxes(1,1)=100*u;%x
    boxes(1,2)=20*u;%y
    boxes(1,3)=41*u;%hight
    boxes(1,4)=40*u;%width

    boxes(2,1)=100*u;%x
    boxes(2,2)=80*u;%y
    boxes(2,3)=41*u;%hight
    boxes(2,4)=40*u;%width

    cMap=ones(ny,nx);

    value=1e-2;


    for k=1:length(boxes(:,1))

        cMap=addboxcmap(cMap,boxes(k,:),value,nx,ny);


    end

    %surf(cMap)

    G = sparse(nx*ny);
    B = zeros(1,nx*ny);


    for i = 1:ny
        for j = 1:nx
            n = i + (j - 1) * ny;

            if j == 1
                G(n, :) = 0;
                G(n, n) = 1;
                B(n) = 1;
            elseif j == nx
                G(n, :) = 0;
                G(n, n) = 1;
            elseif i == 1
                nxm = i + (j - 2) * ny;
                nxp = i + (j) * ny;
                nyp = i + 1 + (j - 1) * ny;

                rxm = (cMap(i, j) + cMap(i , j-1)) / 2.0;
                rxp = (cMap(i, j) + cMap(i , j+1)) / 2.0;
                ryp = (cMap(i, j) + cMap(i+1, j)) / 2.0;

                G(n, n) = -(rxm+rxp+ryp);
                G(n, nxm) = rxm;
                G(n, nxp) = rxp;
                G(n, nyp) = ryp;

            elseif i ==  ny
                nxm = i + (j - 2) * ny;
                nxp = i + (j) * ny;
                nym = i - 1 + (j - 1) * ny;

                rxm = (cMap(i, j) + cMap(i , j-1)) / 2.0;
                rxp = (cMap(i, j) + cMap(i , j+1)) / 2.0;
                rym = (cMap(i, j) + cMap(i-1, j )) / 2.0;

                G(n, n) = -(rxm + rxp + rym);
                G(n, nxm) = rxm;
                G(n, nxp) = rxp;
                G(n, nym) = rym;
            else
                nxm = i + (j-2)*ny;
                nxp = i + (j)*ny;
                nym = i-1 + (j-1)*ny;
                nyp = i+1 + (j-1)*ny;

                rxm = (cMap(i, j) + cMap(i , j-1)) / 2.0;
                rxp = (cMap(i, j) + cMap(i , j+1)) / 2.0;
                rym = (cMap(i, j) + cMap(i-1, j )) / 2.0;
                ryp = (cMap(i, j) + cMap(i+1, j)) / 2.0;

                G(n,n) = -(rxm+rxp+rym+ryp);
                G(n,nxm) = rxm;
                G(n,nxp) = rxp;
                G(n,nym) = rym;
                G(n,nyp) = ryp;
            end

        end
    end

    V = G\B';



    Vmap = zeros(ny,nx);
    for i = 1:ny
        for j = 1:nx
            n = i + (j - 1) * ny;

            Vmap(i, j) = V(n);
        end
    end

    [Ex, Ey] = gradient(-Vmap);
    
    Jx=Ex.*cMap;
    Jy=Ey.*cMap;
    
    Emag=(Ex.^2+Ey.^2).^0.5;
        
    figure(1)
    surf(cMap,'EdgeColor','flat')
    caxis([0 1])
    colorbar
    title('Conduction Map')
    xlabel('x-axis nm')
    ylabel('y-axis nm')
    
    
    view(0,90)
    
    figure(2)
    contourf(Vmap,50)
    title('Voltage Map')
    xlabel('x-axis nm')
    ylabel('y-axis nm')
    view(0,90)
    colorbar
    
    
    figure(3)
    quiver(Ex,Ey)
    title('Electric Field Vector Plot')
    xlabel('x-axis nm')
    ylabel('y-axis nm')
    view(0,90)
    
    
    figure(4)
    quiver(Jx,Jy)
    title('Current Density Vector Plot')
    xlabel('x-axis nm')
    ylabel('y-axis nm')
    view(0,90)
    
%     figure(5)
%     surf(Emag,'EdgeColor','flat')
%     title('Electric Field Magnitude')
%     caxis([0 30])
%     colorbar
%     view(0,90)

    Jleft=sum(Jx(1:ny,1))/ny;
    
    Jright=sum(Jx(1:ny,nx))/ny;

end

fprintf('The left side calculated current density is %7.2s A/nm^2 \n',Jleft)
fprintf('The right side calculated current density is %7.2s A/nm^2 \n',Jright)


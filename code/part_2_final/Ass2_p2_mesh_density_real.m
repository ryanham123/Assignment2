
clear all
clc




global nx ny

clear all

for u=1:4
    


    nx=100*u;
    ny=50*u;

    cMap=ones(ny,nx);

    boxes(1,1)=nx/2;%x
    boxes(1,2)=10*u;%y
    boxes(1,3)=20*u+1;%hight
    boxes(1,4)=20*u;%width

    boxes(2,1)=nx/2;%x
    boxes(2,2)=ny-10*u;%y
    boxes(2,3)=20*u+1;%hight
    boxes(2,4)=20*u;%width

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
    
    

    I_left(u)=sum(Jx(1:ny,1));
    
    I_right(u)=sum(Jx(1:ny,nx));

end


figure(5)
hold on
plot(I_left,'--')
plot(I_right,'o')
title('Current Vs Mesh Density')
legend('Current Entering From Left','Current Leaving From Right')
legend('Location','south')
xlabel('Mesh Scaling Factor')
ylabel('Current (A)')
hold off




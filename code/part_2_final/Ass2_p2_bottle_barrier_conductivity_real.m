
clear all
clc




global nx ny

clear all

for u=1:50
    
    hold off

    nx=200;
    ny=100;

    cMap=ones(ny,nx);

    boxes(1,1)=100;%x
    boxes(1,2)=20;%y
    boxes(1,3)=40+1;%hight
    boxes(1,4)=40;%width

    boxes(2,1)=100;%x
    boxes(2,2)=80;%y
    boxes(2,3)=40+1;%hight
    boxes(2,4)=40;%width


    cMap=ones(ny,nx);

    value=u*2e-2;


    for k=1:length(boxes(:,1))

        cMap=addboxcmap(cMap,boxes(k,:),value,nx,ny);
        
     

    end

%     surf(cMap)
%     view(0,90)
%     caxis([0 1])
%     pause(0.1)

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


figure(8)
plot([1:50]*2e-2,I_left,'-')
hold on
plot([1:50]*2e-2,I_right,'*')
title('Current Vs Barrier Conductivity')
legend('Current Entering From Left','Current Leaving From Right')
legend('Location','south')
xlabel('Barrier Relative Conductivity')
ylabel('Current in amps')
hold off




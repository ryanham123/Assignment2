
clear all
close all
clc
nx=60;
ny=50;

cMap=ones(ny,nx);

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


surf(Vmap)
view(0,90)
colorbar
title('Part A Voltage Map')
xlabel('Length')
ylabel('Width')
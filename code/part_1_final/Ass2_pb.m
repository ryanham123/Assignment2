
clear all
clc
nx=70;
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
            B(n) = 1;
            
        elseif i == 1
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 0;

        elseif i ==  ny
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 0;
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

figure(2)
surf(Vmap)
title(' Voltage Map for Numerical Solution')
view(10,45)



[X,Y] = meshgrid(-(nx-1)/2:(nx-1)/2,0:ny-1);
V=zeros(ny,nx);

a=ny-1;
b=(nx-1)/2;

for t=5:5:250
    
    V=zeros(ny,nx);

    for ni=1:2:t
     V= V+4/pi.*(1./ni).*cosh(ni.*pi.*X/a)/cosh(ni.*pi.*b/a).*sin(ni.*pi.*Y./a);
    end

    figure(3)
    surf(V)
    view(10,45)
    title(strcat(' Voltage Map for Analytical Series Solution  n= ',num2str(t)))
    xlabel('X-Axis')
    ylabel('y-Axis')
    

    
    pause(0.05)

end

figure(4)
plot(1:nx,V(25,:),1:nx,Vmap(25,:),'--')
title('Cross Section y=24')
legend('Analytical Series Solution','Numerical Solution')
legend('Location','north')
xlabel('X-Axis ')
ylabel('Voltage')
axis([0 70 0 1 ])







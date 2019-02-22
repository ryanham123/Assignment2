
clear all
close all
clc

cd code

%%  Introduction
% The purpose of assignment 2 was to solve Laplace's equation using 
% finite difference method for electrostatic potential problems. 

%% Part 1 Introduction 
% The first objective of part one was to solve for the voltage map when V = 1
% Volt at x=0 and V = 0 volts at x = L. The top and bottom boundary 
% conditions where set so that dV/dy = 0. The second objective of part 
% one was to solve for the voltage map when V = 1 volt at x=0, x=L and
% V= 0 volts at y =0, y =W. The numerical solution was then compared with 
% the analytical series solution in order to determine to what extent they 
% agree with each other. The conduction within the rectangular region was 
% set to one everywhere. 

%% Part 1 Figures and Command Line Outputs

cd part_1_final

part1

cd ..   


%% Part 1 Conclusion
% The results of part 1 are as expected. The voltage map relating to the 
% first objective changed linearly in x, constant in y, and satisfied the 
% boundary conditions.  This makes sense given the conduction was the same 
% everywhere and the geometry of the problem. The numerical solution voltage
% map relating to the second objective strongly resembles the analytical
% series solution for large n. One disadvantage of the numerical solution
% is that it requires large amounts of memory in order to store the various
% matrixes. Another disadvantage of the numerical solution is it requires 
% a numerical computing environment that can invert large matrices. 
% An advantage to the numerical solution is it is very fast. One 
% disadvantage of the analytical series solution is for large n the 
% analytical series may not be able to be evaluated. For the analytical 
% series solution provided error began to occur around n=250. Another 
% disadvantage of the analytical series solution is for some problem 
% geometries an analytic series solution can be incredibly tricky or 
% imposable to produce. One advantage of the analytical series solution 
% is that it does not require large amounts of memory or the ability to 
% invert large matrices.  


%% Part 2 Introduction 
% The first objective of part two was to create a model where V = 1 Volt at
% x=0 and V = 0 volts at x = L. The top and bottom boundary conditions where
% set so that dV/dy = 0.  Two boxed areas where also added with low 
% conductivity which created a bottleneck. A voltage map, conductivity
% map, electric field vector plot, and current density vector plot was 
% then determined for the given model.  The second objective of part 
% two was to analysis how meshes density, barrier size, and barrier 
% conductivity effects current. 


%% Part 2 Figures and Command Line Outputs
cd part_2_final

part2

cd ..

%% Part 2 Conclusion
% The results of part two are as expected. The voltage map relating to 
% the first objective changed quickly near the barrier and satisfied the 
% boundary conditions.  The voltage changing quickly near the barrier makes
% sense given the resistance is large near the barrier and ohms law states 
% that the voltage drop is proportional to resistance.  The electric field 
% in general points from left to right and are strongest at the barrier 
% corners. The electric field is also strong within the barrier. This 
% result agrees with theory as areas with high resistance and constant 
% current have relatively large magnetic field strengths.  Current density 
% is very large between the two barriers and small within the barriers. 
% This makes sense, as current will follow through the area with the 
% least resistance. The current density was calculated to be 2.34e-3 A/nm^2 
% on both the left and right side.  This makes sense, as all current 
% following from the left side must leave through the right side due to 
% the upper and lower boundary conditions. For objective two when the mesh 
% size is increased the current appears to converge. This makes sense
% because as the mesh size increases the model becomes a better
% approximation of reality. As barrier width is increased the current 
% appears to drop quickly and then slowly. This makes sense because as 
% the barrier width increases the overall resistance increase rapidity 
% and then slowly. As barrier height is increased the current appears to
% drop slowly and then quickly. This makes sense because as the barrier 
% height increases the overall resistance increase slowly and then quickly 
% as the bottleneck shrinks.  As barrier conductivity is increased the 
% current appears to increase quickly and then slowly. This makes sense 
% because as the barrier conductivity increases the overall resistance
% decreases quickly and then slowly.  



%% Conclusion
% Overall Assignment 2 was a success. I was able to complete every 
% objective and my results match my expectations. 

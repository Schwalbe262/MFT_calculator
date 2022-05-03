clear;
clc;

freq = 30e+3;

h = 6e-3/2;
skin_depth = (1.678/3.14/freq/0.999991/(4*3.14*1e-7))^0.5*1e-3 / 10;
delta = h/skin_depth;

M = 2;

phi1 = (sinh(2*delta) + sin(2*delta)) / (cosh(2*delta) - cos(2*delta));
phi2 = (sinh(1*delta) - sin(1*delta)) / (cosh(1*delta) + cos(1*delta));

Frn = delta * (phi1 + 2/3*(M^2-1)*phi2);

disp("AC/DC ratio : " + Frn)
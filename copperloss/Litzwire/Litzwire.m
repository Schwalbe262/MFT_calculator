clear; clc;

m = 10; % number of layers in the winding
N = 5; % number or tunrs of litz wire in a layer
lw = 10; % length of the middle layer
ns = 700; % number of the strands in the bundle
ds = 0.1e-3; % diameter of the strand
da = 135 * exp(1) - 6*(ns/3)^0.45 * (ds/(40*exp(1)-6))^0.85; % diameter of the bundle

pf = ns*(ds/da)^2;

freq = 0 : 1e+3 : 100e+3;
delta = (1.678/3.14./freq/0.999991/(4*3.14*1e-7)).^0.5*1e-3 / 10; % skin depth

zeta = ds./delta*sqrt(2); % penetration ratio

psi1 = 2*sqrt(2) * (1./zeta + 1/32^8.*zeta.^3 - 1/32^14.*zeta.^5); % skin effect losses in round conductors
psi2 = 1/sqrt(2) * (-1/2^5.*zeta.^3 + 1/2^12.*zeta.^7);% proximity effect losses in round conductor


RF = zeta./sqrt(2) .* (psi1 - pi*ns*pf/24*(16*m^2-1+24/pi^2).*psi2);


plot(freq,RF)
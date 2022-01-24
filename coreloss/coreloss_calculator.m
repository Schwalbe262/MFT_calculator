%% 
clear; clc;

%% 파라미터 입력

N1 = 10;
V1 = 1036;
I1 = 100;

l1 = 20e-3;
l2 = 80e-3;
h1 = 120e-3;
w1 = 80e-3;

core_temp = 100;

core_a = 0.6942;
core_x = 1.4472;
core_y = 2.4769;
core_b = 4.7948;
core_c = 0.0684;
core_d = 4e-4;
core_LT = core_b - core_c*core_temp + core_d*core_temp^2;

per = 3500 * 4 * 3.14 * 1e-7;

freq = 30e+3;


%% calculation

B = V1 / (2*w1*l1) / (2*3.141592*freq) / N1;
V_core = ((h1 + 2*l1)*(4*l1+2*l2)*(w1) - 2*l2*h1*w1);
coreloss = core_a * freq^core_x * B^core_y * core_LT * V_core;

disp("B field : "+B+"T")
disp("coreloss : "+coreloss+"W")
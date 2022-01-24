%%
% 2022/01/24

clear; clc;

%% Input parameter


% mod : 0(coil to plane/default), 1(coil to coil)
mod = 0;

voltage = 60e+3;    
coil_diameter = [1e-3, 6e-3;];
insulator_depth = [2e-3, 2e-3];
air_gap = 8e-3;
len = [coil_diameter,insulator_depth,air_gap];

per_init = 8.854e-12;
per_air = 1;
per_ins = 2.1;
per = [per_init,per_air,per_ins];

res = 1e-4; % resolution


if mod == 1
    d_total = sum(coil_diameter) + sum(insulatior_depth) + air_gap;
else
    d_total = coil_diameter(1) + insulator_depth(1) + air_gap;
end

%% calculation

dis = 0 : res : d_total;

if mod==0
    temp1 = 0 : res : len(1);
    temp2 = len(1)+res : res : len(1)+len(3);
    temp3 = len(1)+len(3)+res : res : d_total;

    temp1 = temp1 * 0;
    temp2 = 1 / 4/pi/per_init/per_ins./temp2 .* ( sin(atan(5000./temp2)) - sin(atan(-5000./temp2)) );
    temp3 = 1 / 4/pi/per_init/per_air./temp3 .* ( sin(atan(5000./temp3)) - sin(atan(-5000./temp3)) );

    E_field = [temp1,temp2,temp3];
    E_field_sum = sum(E_field);
    line_density = voltage/E_field_sum;
    E_field = E_field*line_density/res; % dimension : V/m

end


%% plot


plot(dis*1e+3,E_field/1e+6,"LineWidth",5)
grid on;
xlabel("distance [mm]")
ylabel("E field [kV/mm]")




%%
% 2022/01/24

clear; clc;

%% Input parameter


% mod : 0(coil to plane/default), 1(coil to coil)
mod = 0;

voltage = 60e+3;    
coil_diameter = [1e-3, 6e-3;];
insulator_depth = [5e-3, 2e-3];

per_init = 8.854e-12;
per_air = 1;
per_ins = 2.1;
per = [per_init,per_air,per_ins];

res = 1e-4; % resolution




%% calculation

res_d = 1e-4;
air_end = 100e-3;

ref_ins = 20e+3;
ref_gap = 3e+3;



for air_gap = res_d : res_d : air_end

    len = [coil_diameter,insulator_depth,air_gap];

    if mod == 1
        d_total = sum(coil_diameter) + sum(insulatior_depth) + air_gap;
    else
        d_total = coil_diameter(1) + insulator_depth(1) + air_gap;
    end

    
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

        Epeak_ins = max(temp2*line_density/res);
        Epeak_gap = max(temp3*line_density/res);
    end

    if Epeak_ins < ref_ins*1e+3 && Epeak_gap < ref_gap*1e+3

        sol = air_gap;
        break

    end

end

disp("minimum gap distance : "+sol*1e+3+"mm")




%% plot


plot(dis*1e+3,E_field/1e+6,"LineWidth",5)
grid on;
xlabel("distance [mm]")
ylabel("E field [kV/mm]")




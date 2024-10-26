%% Load Init Conditions
run("..\Init.m")

alt_vec = unique([result_cruise.alt]);
V_vec = unique([result_cruise.V]);
legends = {};

figure()
cont = 1;
for cont1 = 1:length(alt_vec)
    for cont2 = 1:length(V_vec)
        delta_e(cont2,cont1) = result_cruise(cont).opreport.Inputs(2, 1).u;
        delta_thr1(cont2,cont1) = result_cruise(cont).opreport.Inputs(4, 1).u;
        delta_thr2(cont2,cont1) = result_cruise(cont).opreport.Inputs(4, 1).u;
        alpha(cont2,cont1) = rad2deg(result_cruise(cont).opreport.Outputs(11, 1).y);
        theta(cont2,cont1) = rad2deg(result_cruise(cont).opreport.States(2, 1).x);
        cont = cont + 1;
    end
end
for cont = 1:length(delta_e(1,:))
    plot(V_vec,delta_e(:,cont),LineStyle="-")
    hold on
end
grid on


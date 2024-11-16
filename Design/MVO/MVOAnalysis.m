clear all
close all
clc
%% Load Init Conditions
load("..\TrimAndLin\result_cruise.mat")

alt_vec = unique([result_cruise.alt]);
V_vec = unique([result_cruise.V]);
legends = {};

cont = 1;
for cont1 = 1:length(alt_vec)
    for cont2 = 1:length(V_vec)
        res_delta_e(cont2,cont1) = result_cruise(cont).opreport.Inputs(2, 1).u;
        res_delta_thr1(cont2,cont1) = result_cruise(cont).opreport.Inputs(4, 1).u;
        res_delta_thr2(cont2,cont1) = result_cruise(cont).opreport.Inputs(4, 1).u;
        res_alpha(cont2,cont1) = result_cruise(cont).opreport.Outputs(11, 1).y;
        res_theta(cont2,cont1) = result_cruise(cont).opreport.Outputs(8, 1).y;
        res_CL(cont2,cont1) = result_cruise(cont).opreport.Outputs(19, 1).y;
        res_CD(cont2,cont1) = result_cruise(cont).opreport.Outputs(20, 1).y;
        res_Cm(cont2,cont1) = result_cruise(cont).opreport.Outputs(21, 1).y;
        res_nz(cont2,cont1) = result_cruise(cont).opreport.Outputs(22, 1).y;
        res_CLa(cont2,cont1) = result_cruise(cont).opreport.Outputs(23, 1).y;
        res_Cma(cont2,cont1) = result_cruise(cont).opreport.Outputs(24, 1).y;
        cont = cont + 1;
    end
end

%% 
figure()
subplot(2,2,1)
for cont = 1:length(res_delta_e(1,:))
    plot(V_vec,res_delta_e(:,cont),LineStyle="-")
    hold on
end
xlabel('Airspeed [m/s]')
ylabel('\delta_e [deg]')
grid on

subplot(2,2,2)
for cont = 1:length(res_delta_thr1(1,:))
    plot(V_vec,res_delta_thr1(:,cont),LineStyle="-")
    hold on
end
xlabel('Airspeed [m/s]')
ylabel('Throttle Motor 1 [%]')
grid on

subplot(2,2,3)
for cont = 1:length(res_delta_thr2(1,:))
    plot(V_vec,res_delta_thr2(:,cont),LineStyle="-")
    hold on
end
xlabel('Airspeed [m/s]')
ylabel('Throttle Motor 2 [%]')
grid on

subplot(2,2,4)
for cont = 1:length(res_alpha(1,:))
    plot(V_vec,res_alpha(:,cont),LineStyle="-")
    hold on
    plot(V_vec,res_theta(:,cont),LineStyle="-")
end
xlabel('Airspeed [m/s]')
ylabel('Angle [deg]')
grid on

%%
figure()
subplot(2,2,1)
for cont = 1:length(res_CL(1,:))
    plot(V_vec,res_CL(:,cont),LineStyle="-")
    hold on
end
xlabel('Airspeed [m/s]')
ylabel('CL')
grid on

subplot(2,2,2)
for cont = 1:length(res_Cm(1,:))
    plot(V_vec,res_Cm(:,cont),LineStyle="-")
    hold on
end
xlabel('Airspeed [m/s]')
ylabel('Cm')
ylim([-1 1])
grid on

subplot(2,2,3)
for cont = 1:length(res_CL(1,:))
    plot(res_CL(:,cont),res_CD(:,cont),LineStyle="-")
    hold on
end
xlabel('CL')
ylabel('CD')
grid on

subplot(2,2,4)
for cont = 1:length(res_nz(1,:))
    plot(V_vec,res_nz(:,cont),LineStyle="-")
end
xlabel('Airspeed [m/s]')
ylabel('n_Z [-]')
grid on

%%
figure()
subplot(2,2,1)
for cont = 1:length(res_CLa(1,:))
    plot(V_vec,-res_Cma(:,cont)./res_CLa(:,cont),LineStyle="-")
    hold on
end
xlabel('Airspeed [m/s]')
ylabel('SM [%]')
grid on

subplot(2,2,2)
for cont = 1:length(res_Cm(1,:))
    plot(res_delta_e(:,cont),0.1265-(res_Cma(:,cont)./res_CLa(:,cont)),LineStyle="-")
    hold on
end
xlabel('\delta_e [deg]')
ylabel('X_{PN} [m]')
ylim([-1 1])
grid on

subplot(2,2,3)
for cont = 1:length(res_CL(1,:))
    plot(res_alpha(:,cont),res_CL(:,cont),LineStyle="-")
    hold on
end
xlabel('\alpha [deg]')
ylabel('CL [-]')
grid on

subplot(2,2,4)
for cont = 1:length(res_CL(1,:))
    plot(res_delta_e(:,cont),res_CL(:,cont),LineStyle="-")
end
xlabel('\delta_e [deg]')
ylabel('CL [-]')
grid on
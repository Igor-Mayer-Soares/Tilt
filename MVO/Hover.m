run("..\Init.m")
%% On ground
Xe0(3) = -H0;

%% Take-off after 1 second
t = 0:1.2e-3:10;
t = t.';
U = zeros(length(t),9);
U(:,4:7) = 19e3;

%res_sim_takeoff = sim("GT_trim");



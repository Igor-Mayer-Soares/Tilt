%% Load Init Conditions
run("..\..\Init.m")
run("..\ArdupilotParameters.m")

G = result_hover.G([3,14,13],:);  

t = 1:1/1600:20;
t = t.';
u = ones(length(t),4)*0; 

%% Takeoff
Xe0(3) = -H0;
u(:,1) = H0;
for cont = 1:length(t)
    if t(cont) > 5
        u(cont,1) = H0+alt;
    end
end

takeoff = sim('GT_hover.slx');

%% Hover
Xe0(3) = -H0-alt;

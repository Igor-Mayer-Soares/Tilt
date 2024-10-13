%% Load Init Conditions
run("..\..\Init.m")
run("..\ArdupilotParameters.m")

G = result_hover.G([3,14,13],:);  

t = 1:1/1600:10;
t = t.';
u = zeros(length(t),9);

Xe0(3) = -H0;

for cont = 1:length(t)
    for cont1 = 1:length(result_hover.opreport.Inputs)
        u(cont,cont1) = result_hover.opreport.Inputs(cont1).u;
    end
end


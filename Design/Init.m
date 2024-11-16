clear all
close all

%% Add folders to path
curr_dir = pwd;
cd ..\Models\; addpath(pwd)
cd(curr_dir)
cd Models\; addpath(pwd)
cd(curr_dir)
cd Scripts\; addpath(pwd)
cd(curr_dir)

%% GT Model
load("..\AirframeInit\aero.mat")
load("..\AirframeInit\geo.mat")
load("..\AirframeInit\prop.mat")
load("..\AirframeInit\cb.mat")
load("..\AirframeInit\initcond.mat")

SJK_airport = [-23.2165011 -45.9692377].';
SJK_direction = 359;

%% Wind
wind_x = 0;
wind_y = 0;
wind_z = 0;
 
%% Circuit breakers
trim_fw = 1;
lin_fw = 1;
trim_hr = 1;
lin_hr = 1;

%% Trim Fixed Wing
if trim_fw
    alt = 30:10:100;
    V = 10:1:25;
    
    trim_progress = waitbar(0,'Trimming');

    cont = 1;
    for cont1 = 1:length(alt)
        for cont2 = 1:length(V)
            [op,opreport]                     = trim_cruise('GT_trim',V(cont2),(initcond.H0+alt(cont1)));
            result_cruise(cont).alt           = alt(cont1);
            result_cruise(cont).V             = V(cont2);
            if opreport.TerminationString     == "Operating point specifications were successfully met."
                result_cruise(cont).op        = op;
                result_cruise(cont).opreport  = opreport;
                result_cruise(cont).trimmed   = 1;
            else
                result_cruise(cont).op        = op; 
                result_cruise(cont).opreport  = opreport;
                result_cruise(cont).trimmed   = 0;
            end
            waitbar(cont/((length(alt)*length(V))), trim_progress, ...
                    ['Trimming: Height = ', num2str(alt(cont1)), ' m, Airspeed = ', num2str(V(cont2)), ' m/s']);
            cont = cont + 1;
        end
    end
    close (trim_progress);
    save("TrimAndLin\result_cruise","result_cruise",'-v7.3')
else
    load("TrimAndLin\result_cruise");
end

%% Lin Fixed Wing
if lin_fw 
    lin_progress = waitbar(0,'Linearizing');
    stateorder = {'u','w','q','theta','Ze','v','p','r','phi','psi','Xe','Ye'};
    inputname = {'ail','ele','rud','thr1','thr2','thr3','thr4','lambda1','lambda2'};
    outputname = {'ax','ay','az','p','q','r','phi','theta','psi','airspeed','alpha','beta','posX','posY','H','velX','velY','velZ','CL','CD','Cm','nz','CLa','Cma'};
    for cont = 1:length(result_cruise)
        if result_cruise(cont).trimmed
            result_cruise(cont).G = linearize('GT_trim',result_cruise(cont).op,'StateOrder',stateorder);
            result_cruise(cont).G.InputName = inputname;
            result_cruise(cont).G.OutputName = outputname;
        else
            result_cruise(cont).G = [];
        end
        waitbar(cont/(length(result_cruise)), lin_progress, ...
                ['Linearizing: Height = ', num2str(result_cruise(cont).alt), ' m, Airspeed = ', num2str(result_cruise(cont).V), ' m/s']);
    end
    close (lin_progress);
    save("TrimAndLin\result_cruise","result_cruise",'-v7.3')
else
    load("TrimAndLin\result_cruise");
end

%% Trim Hover
if trim_hr
    trim_progress = waitbar(0,'Trimming');

    [op,opreport]          = trim_hover('GT_trim',(initcond.H0+30));
    result_hover.alt       = 30;
    result_hover.V         = 0;
    result_hover.op        = op;
    result_hover.opreport  = opreport;
    result_hover.trimmed   = 1;
    
    close (trim_progress);
    save("TrimAndLin\result_hover","result_hover",'-v7.3')
else
    load("TrimAndLin\result_hover");
end

%% Lin Hover
if lin_hr
    lin_progress = waitbar(0,'Linearizing');
    stateorder = {'u','w','q','theta','Ze','v','p','r','phi','psi','Xe','Ye'};
    inputname = {'ail','ele','rud','thr1','thr2','thr3','thr4','lambda1','lambda2'};
    outputname = {'ax','ay','az','p','q','r','phi','theta','psi','airspeed','alpha','beta','posX','posY','H','velX','velY','velZ','CL','CD','Cm','nz','CLa','Cma'};
    result_hover.G = linearize('GT_trim',result_hover.op,'StateOrder',stateorder);
    result_hover.G.InputName = inputname;
    result_hover.G.OutputName = outputname;
    result_hover.G = result_hover.G(:,4:7);
    close (lin_progress);
    save("TrimAndLin\result_hover","result_hover",'-v7.3')
else
    load("TrimAndLin\result_hover");
end

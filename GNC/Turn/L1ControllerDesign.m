%% Load Init Conditions
run("..\..\Init.m")
run("..\ArdupilotParameters.m")

G = result_cruise(118).G;
G_L1 = G([2,4,6,7,9,12],[1,3]);
Xkeep = {'v';'p';'r';'phi';'psi'};
[~,xElim] = setdiff(G_L1.StateName,Xkeep);
G_L1 = modred(G_L1,xElim,'truncate');

Xe0 = [result_cruise(118).op.States(10).x
       result_cruise(118).op.States(11).x
       result_cruise(118).op.States(12).x];
Vb0 = [result_cruise(118).op.States(7).x
       result_cruise(118).op.States(8).x
       result_cruise(118).op.States(9).x];
euler0 = [result_cruise(118).op.States(1).x
          result_cruise(118).op.States(2).x
          result_cruise(118).op.States(3).x];
wb0 = [result_cruise(118).op.States(4).x
       result_cruise(118).op.States(5).x
       result_cruise(118).op.States(6).x];

U0 = [result_cruise(118).op.Inputs(1).u
      result_cruise(118).op.Inputs(2).u
      result_cruise(118).op.Inputs(3).u
      result_cruise(118).op.Inputs(4).u
      result_cruise(118).op.Inputs(5).u
      result_cruise(118).op.Inputs(6).u
      result_cruise(118).op.Inputs(7).u
      result_cruise(118).op.Inputs(8).u
      result_cruise(118).op.Inputs(9).u];

V0 = result_cruise(118).opreport.Outputs(10).y;
H0 = -Xe0(3);


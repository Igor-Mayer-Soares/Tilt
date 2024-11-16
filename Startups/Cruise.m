cur_dir = pwd;
load("result_cruise.mat");
Vcruise = 15;
H = 40;

idx = find([result_cruise.alt] == H & [result_cruise.V] == Vcruise,1);

initcond.Xe0 = [result_cruise(idx).opreport.States(10:12).x];
initcond.Vb0 = [result_cruise(idx).opreport.States(7:9).x];
initcond.euler0 = [result_cruise(idx).opreport.States(1:3).x];
initcond.wb0 = [result_cruise(idx).opreport.States(4:6).x];
initcond.aileron = result_cruise(idx).opreport.Inputs(1).u;
initcond.elevator = result_cruise(idx).opreport.Inputs(2).u;
initcond.rudder = result_cruise(idx).opreport.Inputs(3).u;
initcond.thr1 = result_cruise(idx).opreport.Inputs(4).u;
initcond.thr2 = result_cruise(idx).opreport.Inputs(5).u;
initcond.thr3 = result_cruise(idx).opreport.Inputs(6).u;
initcond.thr4 = result_cruise(idx).opreport.Inputs(7).u;
initcond.lambda1 = result_cruise(idx).opreport.Inputs(8).u;
initcond.lambda2 = result_cruise(idx).opreport.Inputs(9).u;
cur_dir = pwd;
load("result_hover.mat");

initcond.Xe0 = [result_hover.opreport.States(10:12).x];
initcond.Vb0 = [result_hover.opreport.States(7:9).x];
initcond.euler0 = [result_hover.opreport.States(1:3).x];
initcond.wb0 = [result_hover.opreport.States(4:6).x];
initcond.aileron = result_hover.opreport.Inputs(1).u;
initcond.elevator = result_hover.opreport.Inputs(2).u;
initcond.rudder = result_hover.opreport.Inputs(3).u;
initcond.thr1 = result_hover.opreport.Inputs(4).u;
initcond.thr2 = result_hover.opreport.Inputs(5).u;
initcond.thr3 = result_hover.opreport.Inputs(6).u;
initcond.thr4 = result_hover.opreport.Inputs(7).u;
initcond.lambda1 = result_hover.opreport.Inputs(8).u;
initcond.lambda2 = result_hover.opreport.Inputs(9).u;

initout = [result_hover.opreport.Outputs.y];
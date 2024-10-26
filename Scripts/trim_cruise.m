function [op,opreport] = trim_cruise(model,V,H)
%% Search for a specified operating point for the model - GT_trim.
%
% This MATLAB script is the command line equivalent of the trim model
% tab in linear analysis tool with current specifications and options.
% It produces the exact same operating points as hitting the Trim button.

% MATLAB(R) file generated by MATLAB(R) 24.1 and Simulink Control Design (TM) 24.1.
%
% Generated on: 22-Sep-2024 23:20:59

%% Create the operating point specification object.
opspec = operspec(model);

%% Set the constraints on the states in the model.
% - The defaults for all states are Known = false, SteadyState = true,
%   Min = -Inf, Max = Inf, dxMin = -Inf, and dxMax = Inf.

% State (1) - GT_trim/GT/ /Calculate DCM & Euler Angles/phi theta psi
% - Default model initial conditions are used to initialize optimization.
opspec.States(1).Known = true;
opspec.States(1).SteadyState = false;
opspec.States(1).x = 0;

% State (2) - GT_trim/GT/ /Calculate DCM & Euler Angles/phi theta psi
% - Default model initial conditions are used to initialize optimization.
opspec.States(2).SteadyState = false;

% State (3) - GT_trim/GT/ /Calculate DCM & Euler Angles/phi theta psi
% - Default model initial conditions are used to initialize optimization.
opspec.States(3).Known = true;
opspec.States(3).SteadyState = false;
opspec.States(3).x = 0;

% State (4) - GT_trim/GT/ /p,q,r
% - Default model initial conditions are used to initialize optimization.
opspec.States(4).Known = true;
opspec.States(4).x = 0;

% State (5) - GT_trim/GT/ /p,q,r
% - Default model initial conditions are used to initialize optimization.
opspec.States(5).Known = true;
opspec.States(5).x = 0;

% State (6) - GT_trim/GT/ /p,q,r
% - Default model initial conditions are used to initialize optimization.
opspec.States(6).Known = true;
opspec.States(6).x = 0;

% State (7) - GT_trim/GT/ /ub,vb,wb
% - Default model initial conditions are used to initialize optimization.
opspec.States(7).Known = false;
opspec.States(7).x = V;

% State (8) - GT_trim/GT/ /ub,vb,wb
% - Default model initial conditions are used to initialize optimization.
opspec.States(8).Known = true;
opspec.States(8).x = 0;

% State (9) - GT_trim/GT/ /ub,vb,wb
% - Default model initial conditions are used to initialize optimization.

% State (10) - GT_trim/GT/ /xe,ye,ze
% - Default model initial conditions are used to initialize optimization.
opspec.States(10).SteadyState = false;

% State (11) - GT_trim/GT/ /xe,ye,ze
% - Default model initial conditions are used to initialize optimization.
opspec.States(11).Known = true;
opspec.States(11).x = 0;

% State (12) - GT_trim/GT/ /xe,ye,ze
% - Default model initial conditions are used to initialize optimization.
% opspec.States(12).Known = true;
% opspec.States(12).x = -H;

%% Set the constraints on the inputs in the model.
% - The defaults for all inputs are Known = false, Min = -Inf, and
% Max = Inf.

% Input (1) - GT_trim/aileron
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(1).Known = true;
opspec.Inputs(1).u = 0;

% Input (2) - GT_trim/elevator
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(2).Min = -30;
opspec.Inputs(2).Max = 30;
opspec.Inputs(2).u = -2;

% Input (3) - GT_trim/rudder
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(3).Known = true;
opspec.Inputs(3).u = 0;

% Input (4) - GT_trim/thr1
opspec.Inputs(4).u = 1;
opspec.Inputs(4).Min = 0;
opspec.Inputs(4).Max = 1;

% Input (5) - GT_trim/thr2
opspec.Inputs(5).u = 1;
opspec.Inputs(5).Min = 0;
opspec.Inputs(5).Max = 1;

% Input (6) - GT_trim/thr3
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(6).Known = true;
opspec.Inputs(6).u = 0;

% Input (7) - GT_trim/thr4
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(7).Known = true;
opspec.Inputs(7).u = 0;

% Input (8) - GT_trim/lambda1
opspec.Inputs(8).u = 90;
opspec.Inputs(8).Known = true;

% Input (9) - GT_trim/lambda2
opspec.Inputs(9).u = 90;
opspec.Inputs(9).Known = true;

%% Set the constraints on the outputs in the model.
% - The defaults for all outputs are Known = false, Min = -Inf, and
% Max = Inf.

% Output (13) - GT_trim/V
opspec.Outputs(10).y = V;
opspec.Outputs(10).Known = true;

% Output (14) - GT_trim/nz
opspec.Outputs(3).y = -9.7883;

% Output (13) - GT_trim/V
opspec.Outputs(15).y = H;
opspec.Outputs(15).Known = true;

%% Create the options
opt = findopOptions('DisplayReport','true');
opt.OptimizationOptions.Algorithm = 'sqp';

%% Perform the operating point search.
[op,opreport] = findop(model,opspec,opt);
end

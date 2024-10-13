function [models,controllers] = controllertunning(x,G,controller,gains) 
%% Control Allocation
G_control = [tf(1,4); tf(1,4); tf(1,4); tf(1,4)];
G_control.InputName = 'thr_out';
G_control.OutputName = {'thr1','thr2','thr3','thr4'};

switch controller
    case 'Accz'
%% Requirements 
% Accz trise = 0.1 s
% Overshoot = 0;

%% Internal Loop - Accel - pid_accel_z
        % Plant
        models.AcczG = G;

        % Low Pass Filter Target - x(1) - PSC_models.AcczFLTT
        models.AcczLPF_Target_T = 1/(2*pi*gains.PSC_ACCZ_FLTT);
        models.AcczLPF_Target = tf(1,[models.AcczLPF_Target_T 1]);
        models.AcczLPF_Target.InputName = "target_accz";
        models.AcczLPF_Target.OutputName = "target_models.Acczfiltered";
        
        % Sum block
        Sum1 = sumblk("error_accz = target_models.Acczfiltered - nz");
        
        % Low Pass Filter Error x(2) - PSC_models.AcczFLTE
        models.AcczLPF_Error_T = 1/(2*pi*gains.PSC_ACCZ_FLTE);
        models.AcczLPF_Error = tf(1,[models.AcczLPF_Error_T 1]);
        models.AcczLPF_Error.InputName = "error_accz";
        models.AcczLPF_Error.OutputName = "error_models.Acczfiltered";
        
        % FeedForward Derivative x(3) - PSC_models.AcczD_FF
        models.AcczDFF = tf(gains.PSC_ACCZ_D_FF*1e-3*[1,0],1);
        models.AcczDFF.InputName = "target_models.Acczfiltered";
        models.AcczDFF.OutputName = "target_models.Acczfiltered_DFF";
        
        % FeedForward Gain x(4) - PSC_models.AcczFF
        models.AcczFF = tf(gains.PSC_ACCZ_FF*1e-3);
        models.AcczFF.InputName = "target_models.Acczfiltered";
        models.AcczFF.OutputName = "target_models.Acczfiltered_FF";
        
        % Proportional Gain - x(1) - PSC_models.AcczP
        models.AcczP = tf(x(1));
        models.AcczP.InputName = "error_models.Acczfiltered";
        models.AcczP.OutputName = "error_models.Acczfiltered_P";
        
        % Integrator Gain - x(6) - PSC_models.AcczI
        models.AcczI = tf(x(2),[1 0]);
        models.AcczI.InputName = "error_models.Acczfiltered";
        models.AcczI.OutputName = "error_models.Acczfiltered_I";
        
        % Derivative Error
        models.AcczD_Error = tf([1,0],1);
        models.AcczD_Error.InputName = "error_models.Acczfiltered";
        models.AcczD_Error.OutputName = "error_models.Acczfiltered_preLPF";
        
        % Low Pass Filter Derivative - x(7) - PSC_models.AcczFLTD
        models.AcczLPF_Derivative_T = 1/(2*pi*gains.PSC_ACCZ_FLTD);
        models.AcczLPF_Derivative = tf(1,[models.AcczLPF_Derivative_T 1]);
        models.AcczLPF_Derivative.InputName = "error_models.Acczfiltered_preLPF";
        models.AcczLPF_Derivative.OutputName = "error_models.Acczfiltered_LPF";
        
        % Derivative Gain - x(8) - PSC_models.AcczD
        models.AcczD = tf(x(3));
        models.AcczD.InputName = "error_models.Acczfiltered_LPF";
        models.AcczD.OutputName = "error_models.Acczfiltered_D";
        
        % Add Block
        Add1 = sumblk("thr_out = target_models.Acczfiltered_DFF + target_models.Acczfiltered_FF + error_models.Acczfiltered_P + error_models.Acczfiltered_I + error_models.Acczfiltered_D");
            
        controllers.pid_accel_z = connect(Sum1,Add1,models.AcczD,models.AcczLPF_Derivative,models.AcczD_Error,models.AcczI,models.AcczP,models.AcczFF,models.AcczDFF,models.AcczLPF_Error,models.AcczLPF_Target,{"target_accz","nz"},"thr_out");
        
        models.Acczcloop = connect(models.AcczG,controllers.pid_accel_z,G_control,"target_accz","nz");
end
end
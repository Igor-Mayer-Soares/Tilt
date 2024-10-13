function [fileout] = avl_run(config,alpha,beta)
%--------------------------------------------------------------------
% Run AVL with basic inputs
%%

%Delete old input command file if it exists
if (exist('avl.run','file')~= 0)
    delete avl.run;
end

% Create strings for input/output file names and input commands
avlin   = "LOAD " + config + ".avl";
massin  = "MASS " + config + ".mass";
fileout = "Database/" + "alpha" + num2str(alpha) + "beta" + num2str(beta) + ".st";

Ain     = "A A " + num2str(alpha);
Bin     = "B B " + num2str(beta);

% Input commands
command{1,:}    = avlin;        % Read configuration input file
command{2,:}	= massin;       % Read mass distribution file
command{3,:}	= "mset 0";     % Compute operating-point run cases
command{4,:}	= "OPER";       % Compute operating-point run cases
command{5,:}    = Ain;          % Alpha
command{6,:}    = Bin;         % flap
command{8,:}    = "X";          % eXecute run case
command{9,:}    = "ST";         % Write forces to file
command{10,:}   = fileout;      % Enter forces output file
command{11,:}   = " ";          % Return
command{12,:}   = "Q";          % Quit JVL

% Write input command file (ASCII-delimited)
for cont=1:length(command)
    dlmwrite('avl.run',cell2mat(command{cont}),'-append','delimiter','');
end

% Run JVL
unix('avl < avl.run');

% Delete input command file
delete avl.run;

return
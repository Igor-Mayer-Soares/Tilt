%% Fixed Wing              |%% QUAD          
% Mode                     |% Mode          
% --> Submode              |% --> Submode           
%   --> State              |%   --> State           
% Manual            = 0    |% Manual            = 0
% --> INIT          = 0    |% --> INIT          = 0
% --> Cruise        = 1    |% --> Hover         = 1
%   --> Climb       = 0    |%   --> Free        = 0
%   --> Descent     = 1    |%   --> Level       = 1
%   --> Level       = 2    |%   --> Hold        = 2
%   --> MAYDAY      = 3    |%   --> MAYDAY      = 3
% Auto              = 2    |% Auto              = 2
% --> INIT          = 0    |% --> Takeoff       = 1
% --> Takeoff       = 1    |%   --> Climb       = 1
%   --> Runaway     = 0    |%   --> TOComplete  = 2
%   --> Climb       = 1    |%   --> MAYDAY      = 3
%   --> TOComplete  = 2    |% --> Cruise        = 1
%   --> MAYDAY      = 3    |%   --> Climb       = 0
% --> Cruise        = 1    |%   --> Descent     = 1
%   --> Climb       = 0    |%   --> Level       = 2
%   --> Descent     = 1    |%   --> Loiter      = 3
%   --> Level       = 2    |%   --> MAYDAY      = 4
%   --> Loiter      = 3    |% --> Land          = 1
%   --> MAYDAY      = 4    |%   --> Approach    = 0
% --> Land          = 1    |%   --> Flare       = 1
%   --> Approach    = 0    |%   --> Runaway     = 2
%   --> Flare       = 1    |%   --> LandComplete= 3
%   --> Runaway     = 2    |%   --> MAYDAY      = 4
%   --> LandComplete= 3    |% --> Abort         = 2
%   --> MAYDAY      = 4    |%   --> Climb       = 0
% --> Abort         = 2    |%   --> Loiter      = 1
%   --> Climb       = 0    |
%   --> Loiter      = 1    |


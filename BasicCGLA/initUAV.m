function uav = initUAV(pos, OR, target)
% initUAV initializes UAV structure
%
% Inputs:
%      pos - (x, y) coordinates of starting point
%       OR - observation radius
%   target - assigned target number
%
% Outputs:
%      uav - struct with UAV parameters

uav.state.x = pos(1);
uav.state.y = pos(2);
uav.state.active = true;
uav.state.fuel = 200; % Initialize all UAVs with the same fuel level

uav.trait.or = OR;
uav.trait.target = target;
uav.trait.stateHistory = pos;
uav.trait.path = [];
uav.trait.pathHome = [];
uav.trait.G = [];

end


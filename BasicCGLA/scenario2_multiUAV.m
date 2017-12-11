function [uavs, threats, targets, n] = scenario2_multiUAV()
% scenario1 Initialize simulation elements for scenario 2 with one UAV
%
% Scenario 2 is meant to quickly show the effect of information sharing

% Map size
n = 20;

% Initialize UAV
%   States: x, y, active, fuel
%   Traits: or, target, stateHistory, path, G
uavs{1} = initUAV([5, 3], 3, 2, 1E9);
uavs{2} = initUAV([13, 15], 3, 2, 1E9);

% Initialize targets
%   States: x, y, visited
targets{2}.state.x = 16; 
targets{2}.state.y = 18;
targets{2}.state.visited = false;

% Target 1 = home base
%   Note: target 1 is not used in this scenario
targets{1}.state.x = 18; 
targets{1}.state.y = 1;
targets{1}.state.visited = true;

% Place obstacles
%   States: x, y, found
%   Traits: cov
ii = 1;
threats{ii}.state.x = 7;
threats{ii}.state.y = 5;
threats{ii}.state.found = false;
threats{ii}.trait.cov = eye(2); 

ii = ii + 1;
threats{ii}.state.x = 15;
threats{ii}.state.y = 15;
threats{ii}.state.found = false;
threats{ii}.trait.cov = eye(2); 

ii = ii + 1;
threats{ii}.state.x = 13;
threats{ii}.state.y = 17;
threats{ii}.state.found = false;
threats{ii}.trait.cov = eye(2); 

end
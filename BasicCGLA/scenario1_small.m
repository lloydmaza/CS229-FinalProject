function [uavs, threats, targets, n] = scenario1_small()
% scenario1 Initialize simulation elements for scenario 1
%
% Description: Single UAV and single target initialized on opposite sides
% of the map. Long set of threats placed through the center of the map with
% a small gap.

% Map size
n = 20;

% Initialize UAV
%   States: x, y, active, fuel
%   Traits: or, target, stateHistory, path, G
uavs{1} = initUAV([3, 3], 3, 2, 1E9);

% Initialize targets
%   States: x, y, visited
targets{2}.state.x = 16; 
targets{2}.state.y = 18;
targets{2}.state.visited = false;

% Target 1 = home base
%   Note: target 1 is not used in this scenario
targets{1}.state.x = 1; 
targets{1}.state.y = 1;
targets{1}.state.visited = true;

% Place obstacles
%   States: x, y, found
%   Traits: cov
ii = 1;
threats{ii}.state.x = 10; 
threats{ii}.state.y = 10;
threats{ii}.state.found = false;
threats{ii}.trait.cov = 0.5*eye(2); 

ii = ii + 1;
threats{ii}.state.x = 20; 
threats{ii}.state.y = 9;
threats{ii}.state.found = false;
threats{ii}.trait.cov = eye(2); 

ii = ii + 1;
threats{ii}.state.x = 18; 
threats{ii}.state.y = 11;
threats{ii}.state.found = false;
threats{ii}.trait.cov = eye(2); 

ii = ii + 1;
threats{ii}.state.x = 12; 
threats{ii}.state.y = 10;
threats{ii}.state.found = false;
threats{ii}.trait.cov = 2*eye(2);

ii = ii + 1;
threats{ii}.state.x = 5; 
threats{ii}.state.y = 11;
threats{ii}.state.found = false;
threats{ii}.trait.cov = 0.5*eye(2); 

ii = ii + 1;
threats{ii}.state.x = 2; 
threats{ii}.state.y = 12;
threats{ii}.state.found = false;
threats{ii}.trait.cov = eye(2); 

ii = ii + 1;
threats{ii}.state.x = 8; 
threats{ii}.state.y = 11;
threats{ii}.state.found = false;
threats{ii}.trait.cov = eye(2); 

% ii = ii + 1;
% threats{ii}.state.x = 15; 
% threats{ii}.state.y = 11;
% threats{ii}.state.found = false;
% threats{ii}.trait.cov = eye(2); 

end
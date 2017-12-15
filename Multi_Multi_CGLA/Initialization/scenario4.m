function [uavs, threats, targets, n] = scenario4()
% scenario1 Initialize simulation elements for scenario 13
%
% Description: Multiple UAVs and multiple targets. Threats distributed
% according to the "standard map" from CGLA paper p. 6.

% Map size
n = 20;

% Initialize UAVs
%   States: x, y, active
%   Traits: or, target, stateHistory, path, G
uavs{1} = initUAV([1, 1], 3, 2, 200);
uavs{2} = initUAV([5, 3], 3, 4, 200);

% Initialize targets
%   States: x, y, found
% Target 1 = home base
targets{1}.state.x = 1; 
targets{1}.state.y = 1;
targets{1}.state.visited = true;

targets{2}.state.x = 4; 
targets{2}.state.y = 10;
targets{2}.state.visited = false;

targets{3}.state.x = 14; 
targets{3}.state.y = 19;
targets{3}.state.visited = false;

targets{4}.state.x = 9; 
targets{4}.state.y = 12;
targets{4}.state.visited = false;

% Place obstacles
%   States: x, y, found
%   Traits: cov
threats{1}.state.x = 4; 
threats{1}.state.y = 8;
threats{1}.state.found = false;
threats{1}.trait.cov = eye(2); 

threats{2}.state.x = 6; 
threats{2}.state.y = 6; 
threats{2}.state.found = false;
threats{2}.trait.cov = eye(2);

threats{3}.state.x = 8; 
threats{3}.state.y = 9; 
threats{3}.state.found = false;
threats{3}.trait.cov = eye(2);

threats{4}.state.x = 15; 
threats{4}.state.y = 16;
threats{4}.state.found = false;
threats{4}.trait.cov = eye(2);

threats{5}.state.x = 13; 
threats{5}.state.y = 15;
threats{5}.state.found = false;
threats{5}.trait.cov = eye(2);

threats{6}.state.x = 11; 
threats{6}.state.y = 16;
threats{6}.state.found = false;
threats{6}.trait.cov = eye(2);

threats{7}.state.x = 12; 
threats{7}.state.y = 13;
threats{7}.state.found = false;
threats{7}.trait.cov = 1.1.*eye(2);

threats{8}.state.x = 7.5; 
threats{8}.state.y = 13.5;
threats{8}.state.found = false;
threats{8}.trait.cov = 1.1.*eye(2);




end
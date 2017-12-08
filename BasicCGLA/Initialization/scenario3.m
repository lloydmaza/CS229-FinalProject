function [uavs, threats, targets, n] = scenario3()
% scenario1 Initialize simulation elements for scenario 13
%
% Description: Multiple UAVs and multiple targets. Threats distributed
% according to the "standard map" from CGLA paper p. 6.

% Map size
n = 30;

% Initialize UAVs
%   States: x, y, active
%   Traits: or, target, stateHistory, path, G
uavs{1} = initUAV([2, 1], 3, 2, 200);
% UAVs{2} = initUAV([9, 6], 3, 3);

% Initialize targets
%   States: x, y, found
% Target 1 = home base
targets{1}.state.x = 1; 
targets{1}.state.y = 1;
targets{1}.state.visited = true;

targets{2}.state.x = 5; 
targets{2}.state.y = 11;
targets{2}.state.visited = false;

targets{3}.state.x = 12; 
targets{3}.state.y = 2;
targets{3}.state.visited = false;

% Place obstacles
%   States: x, y, found
%   Traits: cov
threats{1}.state.x = 10; 
threats{1}.state.y = 10;
threats{1}.state.found = false;
threats{1}.trait.cov = 2*eye(2); 

threats{2}.state.x = 5; 
threats{2}.state.y = 4; 
threats{2}.state.found = false;
threats{2}.trait.cov = eye(2);

threats{3}.state.x = 8; 
threats{3}.state.y = 9; 
threats{3}.state.found = false;
threats{3}.trait.cov = 0.5*eye(2);

threats{4}.state.x = 3; 
threats{4}.state.y = 3;
threats{4}.state.found = false;
threats{4}.trait.cov = eye(2);

threats{5}.state.x = 6; 
threats{5}.state.y = 6;
threats{5}.state.found = false;
threats{5}.trait.cov = 2*eye(2);

threats{6}.state.x = 1; 
threats{6}.state.y = 12;
threats{6}.state.found = false;
threats{6}.trait.cov = 3*eye(2);

% threats{7}.state.x = ; 
% threats{7}.state.y = 28;
% threats{7}.state.found = false;
% threats{7}.trait.cov = 0.5*eye(2);


end
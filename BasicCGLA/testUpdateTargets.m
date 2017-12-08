%Checks if threats properly marked as found and flag updates
%TEST 1
uavs = {};
threats = {};
targets = {};
threats{1}.state.x = 10; threats{1}.state.y = 10; threats{1}.trait.cov = 5*eye(2); 
threats{1}.state.found = 0;
threats{2}.state.x = 5; threats{2}.state.y = 4; threats{2}.trait.cov = eye(2);
threats{2}.state.found = 1;
threats{3}.state.x = 8; threats{3}.state.y = 14; threats{3}.trait.cov = eye(2);
threats{3}.state.found = 0;

targets{1}.state.x = 1; targets{1}.state.y = 1; targets{1}.state.visited = 1;
targets{2}.state.x = 2; targets{2}.state.y = 2; targets{2}.state.visited = 0;
targets{3}.state.x = 9; targets{3}.state.y = 8; targets{3}.state.visited = 0;

% targets{2}.state.x = 9; targets{2}.state.y = 10;
% targets{3}.state.x = 15; targets{3}.state.y = 15;
% targets{4}.state.x = 5; targets{4}.state.y = 18;
% targets{5}.state.x = 1; targets{5}.state.y = 1;

uavs{1}.state.x = 9; uavs{1}.state.y = 9; uavs{1}.trait.or = 10;
uavs{2}.state.x = 3; uavs{2}.state.y = 3; uavs{2}.trait.or = 10;

A = computeWeightMatrix(20, threats, 2000);
updateTargets(uavs, targets, A);
%Checks if threats properly marked as found and flag updates
%TEST 1
uavs = {};
threats = {};
threats{1}.state.x = 10; threats{1}.state.y = 10; threats{1}.trait.cov = 5*eye(2); 
threats{1}.state.found = 0;
threats{2}.state.x = 5; threats{2}.state.y = 4; threats{2}.trait.cov = eye(2);
threats{2}.state.found = 0;
threats{3}.state.x = 8; threats{3}.state.y = 14; threats{3}.trait.cov = eye(2);
threats{3}.state.found = 0;

uavs{1}.state.x = 9; uavs{1}.state.y = 9; uavs{1}.trait.or = 10;

[updatedFlag, threats] = checkForThreats(uavs, threats);

if threats{1}.state.found  == 1 && threats{2}.state.found ==1 && threats{3}.state.found ==1 && updatedFlag == 1
    test1Passed = 'true'
else
    test1Passed = 'false'
    threats1Found = threats{1}.state.found
    threats2Found = threats{2}.state.found
    threats3Found = threats{3}.state.found
    updatedFlag = updatedFlag
end
% threats{1}.state.found 
% threats{2}.state.found
% threats{3}.state.found

%Checks UAV Avoidance
%TEST 2
uavs = {};
threats = {};
uavs{1}.state.x = 9; uavs{1}.state.y = 9; uavs{1}.trait.or = 10;
uavs{2}.state.x = 10; uavs{2}.state.y = 10; uavs{2}.trait.or = 10;
[updatedFlag, threats] = checkForThreats(uavs, threats);

if updatedFlag == 1
    test2Passed = 'true'
else 
    test2Passed = 'false'
end

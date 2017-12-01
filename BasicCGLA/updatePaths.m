function UAVs = updatePaths(UAVs, targets, G)
% updatePaths Updates paths for each UAV based on the map's cost matrix
%
% Inputs:
%      UAVs - cell array of structs containing UAV information
%   targets - cell array of structs containing target information
%         G - cost matrix associated with known map
%
% Outputs:
%      UAVs - cell array of structs containing updated UAV information

numUAVs = length(UAVs);

for ii = 1:numUAVs
    uav = UAVs{ii};
    
    targIdx = uav.trait.target;
    target = targets{targIdx};
    
    init = [uav.state.x, uav.state.y];
    fin = [target.state.x, target.state.y];
    
    newPath = findOptPath(init, fin, G);
    
    uav.trait.path = newPath;
    UAVs{ii} = uav;
end

end


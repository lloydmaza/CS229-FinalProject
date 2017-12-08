function [UAVs, uavStop] = updateStates(UAVs, targets)
% updateStates Progresses UAV states along their optimal paths
%
% Inputs:
%      UAVs - cell array of structs containing UAV information
%   targets - cell array of structs containing target information
%
% Outputs:
%      UAVs - cell array of structs containing updated UAV information
%   uavStop - flag indicating whether a UAV went inactive in this step

numUAVs = length(UAVs);

uavStop = false;

for ii = 1:numUAVs
    uav = UAVs{ii};
    
    if uav.state.active
        target = targets{uav.trait.target};
                
        fin = [target.state.x, target.state.y];
        
        currPoint = uav.trait.path(1, :);
        nextPoint = uav.trait.path(2, :);
        
        uav.trait.path(1, :) = [];
        uav.trait.stateHistory = [uav.trait.stateHistory; currPoint];
        
        uav.state.x = nextPoint(1);
        uav.state.y = nextPoint(2);
        
        uav.state.fuel = uav.state.fuel - 1;
        
        % If the UAV is not already on its way to home base, check whether
        % it can make it home from its new state
        if uav.trait.target ~= 1
            home = targets{1};
            homeCoord = [home.state.x, home.state.y];
            
            pathHome = findOptPath(nextPoint, homeCoord, uav.trait.G);
            uav.trait.pathHome = pathHome;
            
            lengthPathHome = size(pathHome, 1);
            
            if lengthPathHome <= uav.state.fuel
                uav.trait.target = 1;
            end
            
        end
        
        if all(nextPoint == fin)
            uav.state.active = false;
            uav.trait.stateHistory = [uav.trait.stateHistory; nextPoint];
            
            uavStop = true;
        end
        
    end
    
    UAVs{ii} = uav;
end

end


function [updatedFlag, threats] = checkForThreats(uavs, threats)
updatedFlag = 0;
numThreats = size(threats,2);
numUavs = size(uavs, 2);

combs = combnk(1:numUavs,2);

for i = 1:size(combs,1)
    dist = sqrt((uavs{combs(i,1)}.state.x - uavs{combs(i,2)}.state.x)^2 ...
                + (uavs{combs(i,1)}.state.y - uavs{combs(i,2)}.state.y)^2);
    if dist < 1.5
        updatedFlag = 1;
        break
    end
end

if updatedFlag == 0
for i = 1:numUavs
    for j = 1:numThreats
        if threats{j}.state.found ~= 1
            dist = sqrt((threats{j}.state.x - uavs{i}.state.x)^2 ...
                + (threats{j}.state.y - uavs{i}.state.y)^2);
            if dist < uavs{i}.trait.or
                threats{j}.state.found = 1;
                updatedFlag = 1;
            end
        end
    end
        
end
end
end
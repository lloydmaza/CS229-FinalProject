function uavs = updateTargets(uavs, targets, A)
%Only assigns active UAVs
unVisitedBool = (cellfun(@(c) c.state.visited, targets));
unVisitedBool = ~unVisitedBool;
unVisited = {targets{unVisitedBool}};
numTargetsUnvis = size(unVisited,2);

activeBool = (cellfun(@(c) c.state.active, uavs));
activeBool = logical(activeBool);
activeUavs = {uavs{activeBool}};
numUavs = size(uavs, 2);

n = sqrt(size(A, 1));
targList = 1:size(targets,2);
uavList = 1:numUavs;
potentialCombs = ones(numUavs, numTargetsUnvis).*10000;

for i = 1:numUavs
    if activeBool(i)
    for j = 1:numTargetsUnvis
        ind1 = sub2ind([n, n], uavs{i}.state.x, uavs{i}.state.y);
        ind2 = sub2ind([n, n], unVisited{j}.state.x, unVisited{j}.state.y);
        potentialCombs(uavList(i), j) = A(ind1,ind2);
        
       
    end
    end
    
end
% tic
[assignment, ~] = munkres(potentialCombs);
% toc
assignment =assignment + 1;
targList = [1 targList(unVisitedBool)];
uavList(activeBool);

for i = 1:numUavs
    uavs{uavList(i)}.trait.target = targList(assignment(i));
end
end
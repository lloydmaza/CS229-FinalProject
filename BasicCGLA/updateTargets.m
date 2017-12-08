function uavs = updateTargets(uavs, targets, A)
test = (cellfun(@(c) c.state.visited, targets));
unVisited = targets{~test};
numTargets = size(targets,2);
numUavs = size(uavs, 2);
n = sqrt(size(A, 1));

potentialCombs = zeros(numUavs, numTargets-1);

for i = 1:numUavs
    for j = 2:numTargets
        ind1 = sub2ind([n, n], uavs{i}.state.x, uavs{i}.state.y);
        ind2 = sub2ind([n, n], targets{j}.state.x, targets{j}.state.y);
        potentialCombs(i,j-1) = A(ind1,ind2);
    end
    
end
tic
[assignment, cost] = munkres(potentialCombs)
toc
end
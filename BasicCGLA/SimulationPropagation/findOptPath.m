function path = findOptPath(init, fin, G)
% findOptPath finds the optimal path between two points on the G matrix
%
% Inputs:
%   init - starting point [x, y]
%    fin - end point [x, y]
%      G - cost matrix associated with known map
%
% Outputs:
%   path - set of optimal waypoints between the desired points

n = size(G, 1);

inds = repmat({[NaN, NaN]}, n + 2);

for ii = 1:n
    for jj = 1:n
        inds{1 + ii, 1 + jj} = [ii, jj];
    end
end

altG = 1E9*ones(n + 2);
altG(2:(end - 1), 2:(end - 1)) = G;

path = init;

while ~all(path(end, :) == fin)
    p0 = path(end, :);
    searchPoints = altG(p0(1):(p0(1) + 2), (p0(2)):(p0(2) + 2));
    searchInds = inds((p0(1)):(p0(1) + 2), (p0(2)):(p0(2) + 2));
    
    [bestRowValues, bestRowInds] = min(searchPoints);
    [~, bestColInd] = min(bestRowValues);
    
    bestRowInd = bestRowInds(bestColInd);
    
    path(end + 1, :) = searchInds{bestRowInd, bestColInd};
end


function A = computeWeightMatrix(n, threats, K)
% computeWeightMatrix generates CLGA weight matrix A
%
%   The A matrix is computed by determining the risk (distance + danger due
%   to threats) between every set of 2 points on the map
%
% Inputs:
%         n - size of simulation map
%   threats - cell array of structs containing threat information
%         K - relative weighting of risk over distance
%
% Outputs:
%         A - weight matrix associated with known map

A = zeros(n^2);

for ii = 1:n^2
    
    [x1, y1] = ind2sub([n, n], ii);
    
    for jj = 1:ii
        
        [x2, y2] = ind2sub([n, n], jj);
        
        dx = x1 - x2;
        dy = y1 - y2;
        
        A(ii, jj) = sqrt(dx^2 + dy^2);
        
        threatDanger = dangerCalc([x1, y1], [x2, y2], threats);
        A(ii, jj) = A(ii, jj) + threatDanger;
        
    end
    
end

A = A + A.';

end


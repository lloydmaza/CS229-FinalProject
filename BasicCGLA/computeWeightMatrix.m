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

A = cell(n);

for i = 1:n
    for j = 1:n
        Aij = zeros(n);
        
        for k = 1:n
            for l = 1:n
                Aij(k, l) = sqrt((i - k)^2 + (j - l)^2);
                
                totalDanger = dangerCalc([i, j], [k, l], threats);
                Aij(k, l) = Aij(k, l) + K*totalDanger;
                
            end
        end
        A{i, j} = Aij;
        
    end
end

end


function A = computeWeightMatrix(n, threats, K)
% computeWeightMatrix generates CLGA matrix A
%
%   Current implementation does not account for integral risk due to
%   obstacles

A = cell(n);

for i = 1:n
    for j = 1:n
        Aij = zeros(n);
        
        for k = 1:n
            for l = 1:n
                Aij(k, l) = sqrt((i - k)^2 + (j - l)^2);
                
                totalRisk = riskCalc([i, j], [k, l], threats);
                Aij(k, l) = Aij(k, l) + K*totalRisk;
                
            end
        end
        A{i, j} = Aij;
        
    end
end

end


function G = computeCostMatrix(n, A, target)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% Initialize G
G0 = 1000*ones(n);
G0(target(1), target(2)) = 0;

% Iterate on G until convergence
iterWithoutChange = 0;

while iterWithoutChange < n^2
    Gnew = G0;
    
    for i = 1:n
        for j = 1:n
            r = [i, j];
            changeMadeInG = false;
            
            for k = 1:n
                for l = 1:n
                    Gnew(k, l) = min([G0(k, l), A{k, l}(i, j) + G0(i, j)]);
                    
                    if Gnew(k, l) ~= G0(k, l)
                        changeMadeInG = true;
                    end
                end
            end
            
            if ~changeMadeInG
                iterWithoutChange = iterWithoutChange + 1;
            end
            
            G0 = Gnew;
            
        end
    end
end

G = Gnew;


% Test path planning script
start = [uavX(1), uavX(2)];
fin = [targX, targY];

p = fin;

G = UAVs{1}.trait.G;

% Ignore the target point
G(fin(1), fin(2)) = inf;

while ~all(p(end, :) == start)
    G(p(end, 1), p(end, 2)) = inf;
    
    [~, minInd] = min(G(:));
    
    [minIndRow, minIndCol] = ind2sub(size(G), minInd);
    
    p(end + 1, :) = [minIndRow, minIndCol];
    
end

figure
plot(p(:, 1), p(:, 2));
    
    
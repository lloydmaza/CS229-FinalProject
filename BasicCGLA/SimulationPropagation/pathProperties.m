function [dist, danger] = pathProperties(path, threats)
% pathProperties Computes the costs of a given path
%
% Inputs:
%     path - array of points on a path
%
% Outputs:
%     dist - total Euclidean distance of the path
%   danger - total danger along the path

numPoints = size(path, 1);

dist = 0;
danger = 0;

for ii = 1:(numPoints  - 1)
    
    init = path(ii, :);
    fin = path(ii + 1, :);
    
    dist = dist + norm(init - fin);
    
    danger = danger + dangerCalc(init, fin, threats);
    
end

end


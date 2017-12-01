function totalDanger = dangerCalc(init, fin, threats)
% dangerCalc calculates the danger between two points on the map
%
% Inputs:
%         init - starting point [x, y]
%          fin - end point [x, y]
%      threats - cell array of structs containing threat information [1xn]
%
% Outputs:
%  totalDanger - danger between two points due to all threats on the map

N = 100; % number of points to discretize the line over

x = linspace(init(1), fin(1), N);
y = linspace(init(2), fin(2), N);
X = [x; y];

numThreats = length(threats);

dangerMult = ones(size(x));
for i = 1:numThreats
    threat = numThreats{i};
    
    mu = [threat.state.x, threat.state.y];
    cov = threat.state.cov;
    
    dangerMult = dangerMult .* (1 - mvnpdf(X', mu, cov))';
end

dangerMult = 1 - dangerMult;

% Integrate the risk over the total distance between the points
d = sqrt((x(end) - x(1))^2 + (y(end) - y(1))^2);
totalDanger = trapz(linspace(0, d, N), dangerMult);
end

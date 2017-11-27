function totalRisk = riskCalc(init, fin, threats)
%init and fin are assumed to be [x, y]
%Sigma is a 2x2 covariance matrix or if diagonal, a 1x2 vector
%Threats is a 1x (number of threats) cell array
%Each threat is {mu vector, sigma matrix}
N = 100; %(number of points to discretize the line over)
x=linspace(init(1),fin(1),N);
y=linspace(init(2),fin(2),N);
X = [x; y];
d = sqrt((x(2)-x(1))^2 + (y(2) - y(1))^2);
numThreats = size(threats,2);

riskMult = ones(size(x));
for i = 1:numThreats
    riskMult = riskMult .* (1 - mvnpdf(X',threats{i}{1},threats{i}{2}))';
end
X';
riskMult = 1-riskMult;
totalRisk = trapz(linspace(0,d,N),riskMult);
end

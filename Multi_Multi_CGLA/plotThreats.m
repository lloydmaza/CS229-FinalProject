function f = plotThreats(n, threats)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

f = figure;

% Plot level curves on the threats
[X, Y] = meshgrid(linspace(1, n, 10*n)); %// all combinations of x, y

Z = zeros(size(X));
for ii = 1:length(threats)
    
    mu = [threats{ii}.state.x, threats{ii}.state.y];
    sigma = threats{ii}.trait.cov;
    
    Zi = mvnpdf([X(:) Y(:)], mu, sigma);
    Zi = reshape(Zi, size(X));
    Z = Z + Zi;
    
end

contour(X./n, Y./n, Z./n);

xlabel('x');
ylabel('y');
axis([0, 1, 0, 1]);

axis equal
grid on
 
ax = gca;
ax.XTick = [0:0.1:1];
ax.YTick = [0:0.1:1];


grid minor


end


% Script to run basic CGLA implementation
clear
close all
clc

tic

% Generate grid map
n = 20;
K = 2E3;

%Initializes all the threats, uavs, and targets
[UAVs, threats, targets] = scenario3();

tic
% Run the simulation while any UAVs are active
numIt = 1;

while any(cellfun(@(c) c.state.active, UAVs))
    
    [updatedFlag, threats] = checkForThreats(UAVs, threats);
    
    if numIt == 1
        updatedFlag = true;
    end
    
    if updatedFlag
        
        A = computeWeightMatrix(n, threats, K);
        UAVs = computeCostMatrix(UAVs, A, targets);
        
        UAVs = updatePaths(UAVs, targets);
        
    end
    
    UAVs = updateStates(UAVs, targets);
    
    numIt = numIt + 1;
    
end

% Plot the optimal paths
figure
for ii = 1:length(UAVs)
    
    uavX = UAVs{ii}.trait.stateHistory(:, 1);
    uavY = UAVs{ii}.trait.stateHistory(:, 2);
    
    targIdx = UAVs{ii}.trait.target;
    targX = targets{targIdx}.state.x;
    targY = targets{targIdx}.state.y;
    
    plot(uavX, uavY, 'k', 'LineWidth', 1.5);
    hold on
    plot(uavX(1), uavY(2), 'or', 'MarkerFaceColor', 'r');
    plot(targX, targY, 'ob', 'MarkerFaceColor', 'b');
    
end

for jj = 1:length(targets)
    
    targX = targets{jj}.state.x;
    targY = targets{jj}.state.y;
    
    if jj == 1
    
        plot(targX, targY, 'gd', 'MarkerFaceColor', 'g');
        
    else
        
        plot(targX, targY, 'ob', 'MarkerFaceColor', 'b');
        
    end
    
end

xlabel('x');
ylabel('y');
axis(n*[0, 1, 0, 1]);

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

contour(X, Y, Z);

axis equal
grid on

toc
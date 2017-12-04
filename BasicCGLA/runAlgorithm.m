% Script to run basic CGLA implementation
clear
close all
clc

tic

% Generate grid map
n = 20;
K = 2E3;

% Initialize UAVs
%   States: x, y, active
%   Traits: or, target, stateHistory, path
UAVs{1} = initUAV([2, 1], 3, 1);
UAVs{2} = initUAV([18, 6], 3, 1);

% Initialize targets
%   States: x, y, found
targets{1}.state.x = 10; 
targets{1}.state.y = 16;
targets{1}.state.found = true;

% Place obstacles
%   States: x, y, found
%   Traits: cov
threats{1}.state.x = 10; 
threats{1}.state.y = 10;
threats{1}.state.found = false;
threats{1}.trait.cov = 5*eye(2); 

threats{2}.state.x = 5; 
threats{2}.state.y = 4; 
threats{2}.state.found = false;
threats{2}.trait.cov = eye(2);

threats{3}.state.x = 8; 
threats{3}.state.y = 14;
threats{3}.state.found = false;
threats{3}.trait.cov = eye(2);

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
        G = computeCostMatrix(A, targets);
        
        UAVs = updatePaths(UAVs, targets, G);
        
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

xlabel('x');
ylabel('y');
axis(n*[0, 1, 0, 1]);

% Plot level curves on the threats
[X, Y] = meshgrid(linspace(1, n, 10*n)); %// all combinations of x, y

for ii = 1:length(threats)
    mu = [threats{ii}.state.x, threats{ii}.state.y];
    sigma = threats{ii}.trait.cov;
    
    Z = mvnpdf([X(:) Y(:)], mu, sigma);
    Z = reshape(Z, size(X));
    h2 = contour(X, Y, Z);
end
axis equal
grid on

toc
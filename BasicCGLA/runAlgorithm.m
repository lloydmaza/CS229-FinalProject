% Script to run basic CGLA implementation
clear
close all
clc

tic

% Generate grid map
n = 30;
K = 1E3;

% Initialize UAVs
%   States: x, y, active
%   Traits: or, target, stateHistory, path, G
UAVs{1} = initUAV([2, 1], 3, 1);
UAVs{2} = initUAV([18, 6], 3, 2);

% Initialize targets
%   States: x, y, found
targets{1}.state.x = 10; 
targets{1}.state.y = 26;
targets{1}.state.found = true;

targets{2}.state.x = 22; 
targets{2}.state.y = 17;
targets{2}.state.found = true;

% Place obstacles
%   States: x, y, found
%   Traits: cov
threats{1}.state.x = 10; 
threats{1}.state.y = 10;
threats{1}.state.found = false;
threats{1}.trait.cov = 2*eye(2); 

threats{2}.state.x = 5; 
threats{2}.state.y = 4; 
threats{2}.state.found = false;
threats{2}.trait.cov = eye(2);

threats{3}.state.x = 8; 
threats{3}.state.y = 9; 
threats{3}.state.found = false;
threats{3}.trait.cov = 0.5*eye(2);

threats{4}.state.x = 8; 
threats{4}.state.y = 14;
threats{4}.state.found = false;
threats{4}.trait.cov = eye(2);

threats{5}.state.x = 15; 
threats{5}.state.y = 13;
threats{5}.state.found = false;
threats{5}.trait.cov = 2*eye(2);

threats{6}.state.x = 3; 
threats{6}.state.y = 27;
threats{6}.state.found = false;
threats{6}.trait.cov = 3*eye(2);

threats{7}.state.x = 24; 
threats{7}.state.y = 28;
threats{7}.state.found = false;
threats{7}.trait.cov = 0.5*eye(2);

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
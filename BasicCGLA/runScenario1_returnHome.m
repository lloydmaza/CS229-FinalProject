% Script to run basic CGLA implementation
clear
close all
clc

tic

%Initializes all the threats, uavs, and targets
[UAVs, threats, targets, n] = scenario1_small();
K = 2E3;

tic
% Run the simulation while any UAVs are active
numIt = 1;

while any(cellfun(@(c) c.state.active, UAVs))
    
    [updatedFlag, threats] = checkForThreats(UAVs, threats);
    
    if numIt == 1
        updatedFlag = true;
    end
    
    if updatedFlag || stoppedFlag
        
        A = computeWeightMatrix(n, threats, K);
        UAVs = computeCostMatrix(UAVs, A, targets);
        
        UAVs = updatePaths(UAVs, targets);
        
    end
    
    [UAVs, stoppedFlag] = updateStates(UAVs, targets);
    
    if stoppedFlag && (UAVs{1}.trait.target == 2)
        
        targets{2}.visited = true;
        
        UAVs{1}.state.active = true;
        UAVs{1}.trait.target = 1;
        
    end
    
    numIt = numIt + 1;
    
end

% Plot the threats
f = plotThreats(n, threats);
hold on

% Plot the optimal path and the target
for ii = 1:length(UAVs)
    
    uavX = UAVs{ii}.trait.stateHistory(:, 1);
    uavY = UAVs{ii}.trait.stateHistory(:, 2);
    
%     plot(uavX./n, uavY./n, 'k', 'LineWidth', 1.5);
    plot(uavX./n, uavY./n, 'k');
    hold on
    plot(uavX(1)./n, uavY(2)./n, 'or', 'MarkerFaceColor', 'r');
    
end

% Ignore the first target (home base)
for jj = 1:length(targets)
    
    targX = targets{jj}.state.x;
    targY = targets{jj}.state.y;
    
    
    if jj == 1
    
        plot(targX./n, targY./n, 'gd', 'MarkerFaceColor', 'g');
        
    else
        
        plot(targX./n, targY./n, 'ob', 'MarkerFaceColor', 'b');
        
    end
    
end

% xlabel('x');
% ylabel('y');
% axis(n*[0, 1, 0, 1]);
%
% % Plot level curves on the threats
% [X, Y] = meshgrid(linspace(1, n, 10*n)); %// all combinations of x, y
%
% Z = zeros(size(X));
% for ii = 1:length(threats)
%
%     mu = [threats{ii}.state.x, threats{ii}.state.y];
%     sigma = threats{ii}.trait.cov;
%
%     Zi = mvnpdf([X(:) Y(:)], mu, sigma);
%     Zi = reshape(Zi, size(X));
%     Z = Z + Zi;
%
% end
%
% contour(X, Y, Z);
%
% axis equal
% grid on

toc

beep
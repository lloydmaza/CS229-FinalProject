% Script to run basic CGLA implementation
clear
close all
clc

tic

%Initializes all the threats, uavs, and targets
[UAVs, threats, targets, n] = scenario1_multiUAV();
K = 2E3;

% Plot the true threat layout
f0 = plotThreats(n, threats);
hold on
plot(UAVs{1}.state.x/n, UAVs{1}.state.y/n, 'ro', 'MarkerFaceColor', 'r');
plot(targets{2}.state.x/n, targets{2}.state.y/n, 'bo', 'MarkerFaceColor', 'b');

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
    
    % Any time a new threat is found, plot the known threats, the state
    % history, and the intended path
    if updatedFlag
        
        knownThreatsMask = cellfun(@(c) logical(c.state.found), threats);
        knownThreats = {threats{knownThreatsMask}};
        
        plotThreats(n, knownThreats);
        hold on
        
        uav = UAVs{1};
        init = uav.trait.stateHistory(1, :);
        curr = [uav.state.x, uav.state.y];
        
        target = targets{uav.trait.target};
        fin = [target.state.x, target.state.y];
        
        plot(curr(1)./n, curr(2)./n, 'ok', 'MarkerFaceColor', 'k');
        plot(init(1)./n, init(2)./n, 'or', 'MarkerFaceColor', 'r');
        plot(fin(1)./n, fin(2)./n, 'ob', 'MarkerFaceColor', 'b');
        
        hist = [uav.trait.stateHistory; curr];
        path = uav.trait.path;
        
        plot(hist(:, 1)./n, hist(:, 2)./n, 'k');
        plot(path(:, 1)./n, path(:, 2)./n, 'k--');      
        
    end
    
    UAVs = updateStates(UAVs, targets);
    
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
    plot(uavX(1)./n, uavY(1)./n, 'or', 'MarkerFaceColor', 'r');
    
end

% Ignore the first target (home base)
for jj = 2:length(targets)
    
    targX = targets{jj}.state.x;
    targY = targets{jj}.state.y;
    
    
    plot(targX./n, targY./n, 'ob', 'MarkerFaceColor', 'b');
    
end

% Generate a surface plot of the G matrix
G = UAVs{1}.trait.G;
% [X, Y] = meshgrid(1:n, 1:n);
figure
surface(G');

toc
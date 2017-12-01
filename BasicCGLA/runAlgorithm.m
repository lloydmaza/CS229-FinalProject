% Script to run basic CGLA implementation
clear
close all
clc

tic

% Generate grid map
n = 20;

% Place initial point and target
init = [2, 1];
uavs{1}.state.x = 2; uavs{1}.state.y = 1; uavs{1}.trait.or = 2;
% target = [10, 16];
targets{1}.state.x = 10; 
targets{1}.state.y = 16;

% Place obstacles
threats{1}.state.x = 10; threats{1}.state.y = 10; threats{1}.trait.cov = 5*eye(2); 
threats{1}.state.found = 1;
% threats{1} = {[10 10], 5*eye(2)};
threats{2}.state.x = 5; threats{2}.state.y = 4; threats{2}.trait.cov = eye(2);
threats{2}.state.found = 1;
% threats{2} = {[5 4], eye(2)};
threats{3}.state.x = 8; threats{3}.state.y = 14; threats{3}.trait.cov = eye(2);
threats{3}.state.found = 1;
% threats{3} = {[8, 14], eye(2)};

% Compute the weight matrix A
A = computeWeightMatrix(n, threats, 2E3);


[updatedFlag, threats] = checkForThreats(uavs, threats);
%Implementation of updated A based on currently found threats
count = 0;
curThreats = {};
if updatedFlag == 1
    for j = 1:numThreats
        if threats{j}.state.found == 1
            curThreats{count+1} = threats{j};
            count = count+1;
        end
    end
    
    A = computeWeightMatrix(size(A,1), threats, K);
end


% Compute the cost matrix G
G = computeCostMatrix( A, targets);

% Plan the optimal path
optPath = findOptPath(init, [targets{1}.state.x, targets{1}.state.y], G);

% Plot the optimal path
figure
h1 = plot(optPath(:, 1), optPath(:, 2), 'k', 'LineWidth', 1.5);
hold on
plot(init(1), init(2), 'or', 'MarkerFaceColor', 'r');
plot(targets{1}.state.x, targets{1}.state.y, 'ob', 'MarkerFaceColor', 'b');
xlabel('x');
ylabel('y');
axis(n*[0, 1, 0, 1]);

text(init(1), init(2), '  Start Point');
text(targets{1}.state.x, targets{1}.state.y, '  Target');

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
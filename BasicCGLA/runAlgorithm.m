% Script to run basic CGLA implementation
clear
close all
clc

tic

% Generate grid map
n = 20;

% Place initial point and target
init = [2, 1];
target = [10, 16];

% Place obstacles
threats{1} = {[10 10], 5*eye(2)};
threats{2} = {[5 4], eye(2)};
threats{3} = {[8, 14], eye(2)};


% Compute the weight matrix A
A = computeWeightMatrix(n, threats, 2E3);

% Compute the cost matrix G
G = computeCostMatrix(n, A, target);

% Plan the optimal path
optPath = findOptPath(init, target, G);

% Plot the optimal path
figure
h1 = plot(optPath(:, 1), optPath(:, 2), 'k', 'LineWidth', 1.5);
hold on
plot(init(1), init(2), 'or', 'MarkerFaceColor', 'r');
plot(target(1), target(2), 'ob', 'MarkerFaceColor', 'b');
xlabel('x');
ylabel('y');
axis(n*[0, 1, 0, 1]);

text(init(1), init(2), '  Start Point');
text(target(1), target(2), '  Target');

% Plot level curves on the threats
[X, Y] = meshgrid(linspace(1, n, 10*n)); %// all combinations of x, y

for ii = 1:length(threats)
    mu = threats{ii}{1};
    sigma = threats{ii}{2};
    
    Z = mvnpdf([X(:) Y(:)], mu, sigma);
    Z = reshape(Z, size(X));
    h2 = contour(X, Y, Z);
end
axis equal
grid on

toc
% Script for generating a sample figure showing the relationship between
% the threat distribution (F) and a point in the risk matrix (A)
clear
close all
clc

% Generate some threats
n = 20;

ii = 1;
threats{ii}.state.x = 10; 
threats{ii}.state.y = 10;
threats{ii}.state.found = true;
threats{ii}.trait.cov = eye(2); 

ii = ii + 1;
threats{ii}.state.x = 8; 
threats{ii}.state.y = 11;
threats{ii}.state.found = true;
threats{ii}.trait.cov = eye(2); 

ii = ii + 1;
threats{ii}.state.x = 12; 
threats{ii}.state.y = 9;
threats{ii}.state.found = true;
threats{ii}.trait.cov = eye(2);

% Compute the risk matrix from point 1 to every other point
p1 = [2, 2];

A = zeros(n);
K = 2E2;

for ii = 1:n
    for jj = 1:n
        
        p2 = [ii, jj];
        
        dist = norm(p1 - p2);
        
        threatDanger = dangerCalc(p1, p2, threats);
        A(ii, jj) = dist + K*threatDanger;
    end
end

plotThreats(n, threats);
hold on
plot(p1(1)./n, p1(2)./n, 'ko', 'MarkerFaceColor', 'k');

figure
[X, Y] = meshgrid(linspace(0, 1, n), linspace(0, 1, n));
surface(X, Y, A.');
hold on
plot3(p1(1)./n, p1(2)./n, A(2, 2), 'ko', 'MarkerFaceColor', 'k');
view(3);
grid on

colormap jet


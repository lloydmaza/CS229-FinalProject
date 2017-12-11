% Script for testing scenario threat placements
clear
close all
clc

% % Scenario 1
% [uavs, threats, targets, n] = scenario1();
% plotThreats(n, threats);
% 
% % Scenario 1 Small
% [uavs, threats, targets, n] = scenario1_small();
% plotThreats(n, threats);

% Scenario 2
[uavs, threats, targets, n] = scenario2_singleUAV();
plotThreats(n, threats);
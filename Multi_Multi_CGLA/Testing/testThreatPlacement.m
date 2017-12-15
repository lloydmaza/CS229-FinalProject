% Script for testing scenario threat placements
clear
close all
clc

% Scenario 1
[uavs, threats, targets, n] = scenario1();
% plotThreats(n, threats);

%Scenario 3
[uavs3, threats3, targets3, n] = scenario5();
plotThreats(n, threats3)

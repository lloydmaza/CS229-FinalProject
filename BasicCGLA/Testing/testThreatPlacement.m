% Script for testing scenario threat placements
clear
close all
clc

% Scenario 1
[uavs, threats, targets, n] = scenario1();
plotThreats(n, threats);
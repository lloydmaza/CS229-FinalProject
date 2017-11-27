n = 10; %Number of grid squares to break this into
[X, Y] = meshgrid(1:n,1:n);

targets = [5,6, 1000];
gamma = .7;

numIter = 1;
maxIt = 1;
initFuel = 10;
fullStateHistory = cell(maxIt);

while numIter <= maxIt
    state = [1 1 0 15];
    stateHistory = zeros(initFuel,4);
    i = 1;
    while state(4) > 0
        stateHistory(i,:) = state;
        newState = policy(state, targets);
        state = newState;
        i = i+1;
    end
    fullStateHistory{numIter} = stateHistory;
    numIter = numIter + 1;
    
end

figure
xpos = fullStateHistory{1}(:, 1);
ypos = fullStateHistory{1}(:, 2);
plot(xpos, ypos, 'ok-', 'MarkerFaceColor', 'k');
hold on
plot(targets(1), targets(2), 'or', 'MarkerFaceColor', 'r');
grid on
axis([0, 10, 0, 10]);
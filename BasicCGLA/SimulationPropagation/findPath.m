function path = findPath(G,init, fin)
[r, c] = size(G);

fakeG = ones(r+2,c+2)*1e7;

fakeG(2:end-1, 2:end-1) = G;
state = init;
stateHistory = state;
while state ~= fin
    neighbors = reshape(fakeG(state(1):state(1)+2, state(2):state(2)+2), [1,9]);
    neighbors(5) = 1e7;
    [~, ind] = min(neighbors);
    
    if ind == 1
        newState = [state(1)-1,state(2)+1];
    elseif ind == 2
        newState = [state(1),state(2) + 1];
    elseif ind == 3
        newState = [state(1) + 1, state(2)+1];
    elseif ind == 4
        newState = [state(1)-1,state(2)];
    elseif ind == 6
        newState = [state(1)+1, state(2)];
    elseif ind == 7
        newState = [state(1)-1, state(2)-1];
    elseif ind == 8
        newState = [state(1),state(2)-1];
    elseif ind == 9
        newState = [state(1)+1,state(2)-1];
    end
    stateHistory = [stateHistory;newState];
    state = newState;
end
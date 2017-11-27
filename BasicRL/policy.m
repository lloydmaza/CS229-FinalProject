function out = policy(state, targets)
minFuel = 10;

nextStates = zeros(4,size(state,2));

nextStates(1,:) = [state(1) + 1, state(2), state(3), state(4)-1];
nextStates(2,:) = [state(1) - 1, state(2), state(3), state(4)-1];
nextStates(3,:) = [state(1), state(2) + 1, state(3), state(4)-1];
nextStates(4,:) = [state(1), state(2) - 1, state(3), state(4)-1];

r = zeros(size(state,2),1);
for i = 1:4
    r(i) = reward(nextStates(i,:), targets);
end
r = r;
[~, indices] = sort(r,'descend');
ind = randsample([randi([1 4],1,1) indices(1)], 1, true, [.3 .7]);
out = nextStates(ind,:);
end
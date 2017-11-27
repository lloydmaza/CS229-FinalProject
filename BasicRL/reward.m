function out = reward(state, targets)
% Notes is state = [xPos yPos info fuel]

rDist = sqrt((state(1)-targets(1))^2 + (state(2) - targets(2))^2);

if rDist == 0
    out = targets(3);
elseif state(1) < 0 || state(1) > 10 || state(2) < 1 || state(2) > 10
    out = -1;
else
    out = 1/rDist;
end

end
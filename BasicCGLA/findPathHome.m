function pathHome = findPathHome(init, home)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

pathHome = init;
p0 = init;

while ~all(p0 == home)
    
%     u = p0 - home;
u = home - p0;
    u = u./norm(u);
    
    p1 = round(p0 + u);
    
    pathHome(end + 1, :) = p1;
    
    p0 = p1;
    
end


end


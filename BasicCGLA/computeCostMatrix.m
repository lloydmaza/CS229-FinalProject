function G = computeCostMatrix(A, targs)
% computeCostMatrix generates CGLA cost matrix G
%
% Inputs:
%       A - weight matrix associated with known map
%   targs - cell array of structs containing target information
%
% Outputs:
%       G - cost matrix associated with known map

% Initialize G
n = sqrt(size(A, 1));
numTargs = length(targs); 

G0 = 1000*ones(n);

for ii = 1:numTargs
    currTarg = targs{ii};
    x = currTarg.state.x;
    y = currTarg.state.y;
    
    G0(x, y) = 0;
end

% Iterate on G until convergence
iterWithoutChange = 0;

while iterWithoutChange < n^2
    Gnew = G0;
    
    for jj = 1:n
        for kk = 1:n
            r = [jj, kk];
            changeMadeInG = false;
            
            for pp = 1:n
                for qq = 1:n
                    
                    ind1 = sub2ind([n, n], jj, kk);
                    ind2 = sub2ind([n, n], pp, qq);
                    
                    Gnew(pp, qq) = min([G0(pp, qq), A(ind1, ind2) + G0(jj, kk)]);
                    
                    if Gnew(pp, qq) ~= G0(pp, qq)
                        changeMadeInG = true;
                    end
                end
            end
            
            if ~changeMadeInG
                iterWithoutChange = iterWithoutChange + 1;
            end
            
            G0 = Gnew;
            
        end
    end
end

G = Gnew;


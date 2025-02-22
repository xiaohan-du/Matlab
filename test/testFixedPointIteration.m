clear; clc; 
% this script tests theory of fixed point iteration.
% find a root of x^4 - x - 10 = 0.
%% g1(x) = 10 / (x ^ 3 - 1).
g1 = 2;

for it = 1:10
    
    g1 = 10 / (g1 ^ 3 - 1);
    disp(g1)
    
end

% g1 does not converge.

%% g2(x) = (x + 10) ^ 0.25.
g2 = 2;

for it = 1:20
    g20 = g2;
    g2 = (g2 + 10) ^ 0.25;
    g22 = g2;
    tol = g22 - g20;
    disp(tol)
    
end
% g2 converges at 1.8556.

%% g3(x) = (sqrt(x + 10)) / x.
g3 = 1.8;

for it = 1:200
    g30 = g3;
    g3 = (sqrt(g3 + 10)) / g3;
    g32 = g3;
    tol = g32 - g30;
    disp(tol)
    
end
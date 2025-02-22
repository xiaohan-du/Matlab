% this script tests trace(a' * b) vs using for loop with vector products,
% see which one is faster.

clear; clc;
nd = 50000;
nt = 5000;
A = rand(nd, nt);
B = rand(nd, nt);
%% no SVD.
% option 1.
tic
abTr = trace(A' * B);
toc
% option 2.
tic
abSum = 0;
for j = 1:nt
    abSum = abSum + A(:, j)' * B(:, j);
end
toc

%% SVD.
[ua, sa, va] = svd(A, 0);
[ub, sb, vb] = svd(B, 0);


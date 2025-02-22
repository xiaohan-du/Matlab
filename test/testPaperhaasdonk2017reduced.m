clear; clc;
% this script tests RB-tutorial by B.H.
a1 = [3 2 1 4; 4 5 6 7; 8 9 3 2];

[u1, s1, v1] = svd(a1, 0);
s1Diag = diag(s1);

[eigVec, eigVal] = eig(a1 * a1');
eigDiag = sort(diag(eigVal), 'descend');

n = 1;
phi1 = u1(:, 1:n);

pErr1 = norm(a1 - phi1 * phi1' * a1, 'fro');
pErr1s = sqrt(sum((s1Diag(n + 1 : end).^2)));
pErr1e = sqrt(sum(eigDiag(n + 1 : end)));

a2 = [1 2 3 4; 4 7 8 2; 9 9 8 6];

[u2, s2, v2] = svd(a2, 0);

phi2 = u2(:, 1:n);

pErrAve = (norm(a1 - phi1 * phi1' * a1) ^ 2 + norm(a2 - phi2 * phi2' * a2) ^ 2) / 2;
clear; clc;

% Generate two M-by-N matrices
m = 242;
n = 5;
nd = 1034;
nt = 50;
p = 20;
U1 = rand(nd, nt);
U2 = rand(nd, nt);
U1q = U1(1:m, 1:n);
U2q = U2(1:m, 1:n);

% Get SVDs
[ua, sa, va]=svd(U1, 0);
[ub, sb, vb]=svd(U2, 0);

ua = ua(1:m, 1:p);
ub = ub(1:m, 1:p);
sa = sa(1:p, 1:p);
sb = sb(1:p, 1:p);
va = va(1:n, 1:p);
vb = vb(1:n, 1:p);



% Get diagonal entries of C=A'*B; i-th diagonal element = dot product
% between i-th columns of A and B
cDiag = zeros(n, 1);
tic
for j = 1:nt
    % Pre-multiply D and V'
    vas = sa * va';
    vbs = sb * vb';
    for i = 1:n
        U1n = ua * vas(:, i); % n-th column of A <--> n-th row of transpose(A)
        U2n = ub * vbs(:, i); % n-th column of B
        cDiag(i) = U1n' * U2n;
        keyboard
    end
    cSum = sum(cDiag);
end
toc
tic
for j = 1:nt
    
    cTr = trace((vb' * va) * sa' * (ua' * ub) * sb);
    
end
toc
% Verify computed solution
cDiagRef = diag(U1q' * U2q);
eM = max(abs(cDiag - cDiagRef));
disp(eM)
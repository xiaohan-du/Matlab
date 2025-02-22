clc; clf;
plotData;
% this script plots figures of I beam 3146 nodes.
%% part 1:convergence.
cd ~/Desktop/Temp/thesisResults/13082018_0949_Ibeam/3146nodes/trial=1;
load('errOriginalIter20Add4.mat', 'errOriginalIter20Add4')
load('errProposedNouiTujIter20Add4.mat', 'errProposedNouiTujIter20Add4')

nInit = 3;
nAdd = 3;
nRb = 60;
errx = (nInit:nAdd:nRb);

% extract error values at proposed magic points.
% manually find location of ehhat in original.

% errProLoc = [5 1; 9 1; 9 1; 1 1; 9 1; 1 1; 9 1; 9 1; 9 1; 9 9; ...
%     9 9; 9 9; 9 9; 9 9; 9 9; 9 9; 9 9; 9 9; 5 1; 5 1]; % for trial = 1
% errProLoc = [1 1; 1 1; 1 9; 1 9; 5 1; 9 1; 9 1; 9 1; 1 1; 9 1]; % for trial = 1089
% errProLoc = [1 1; 1 1; 9 1; 9 1; 1 1; 9 1; 5 9; 1 9; 5 1; 1 9]; % for trial = 33

% errProLoc = [9 1; 1 1; 9 1; 9 1; 9 1; 1 1; 1 1; 9 1; 5 1; 5 9; ...
%     1 9; 1 9; 1 1; 1 9; 1 9; 1 9; 1 9; 7 1; 5 1; 5 1]; % for trial = 1, add 3.
errProLoc = [1 1; 9 1; 9 1; 1 1; 1 1; 1 9; 5 1; 1 9; 9 1; 9 1; ...
    9 1; 1 9; 1 9; 1 1; 5 1; 1 9; 5 1; 5 1; 7 1; 1 9]; % for trial = 1089, add 3.
errOriLoc = errOriginalIter20Add4.store.realLoc;
errProMax = zeros(length(errProLoc), 1);
errOriMax = zeros(length(errProLoc), 1);
phiPro = errProposedNouiTujIter20Add4.phi.val;
phiOri = errOriginalIter20Add4.phi.val;

K1 = canti.sti.mtxCell{1};
K2 = canti.sti.mtxCell{2};
M = canti.mas.mtx;
F = canti.fce.val;

dt = canti.time.step;
maxt = canti.time.max;
U0 = zeros(length(K1), 1);
V0 = zeros(length(K1), 1);
phiid = eye(length(K1));
qd = canti.qoi.dof;
qt = canti.qoi.t;
pm1 = logspace(-1, 1, 9);
pm2 = logspace(-1, 1, 9);
for ic = 1:20
    % knowing magic point.
    % calculate 1 reduced variable --> approximation --> error.
    nic = 3 * ic;
    
    % proposed.
    phivPro = phiPro(:, 1:nic);
    pmpro = [pm1(errProLoc(ic, 1)) pm2(errProLoc(ic, 2))];
    Kpro = K1 * pmpro(1) + K2 * 1;
    Cpro = K1 * pmpro(2);
    mpro = phivPro' * M * phivPro;
    kpro = phivPro' * Kpro * phivPro;
    cpro = phivPro' * Cpro * phivPro;
    fpro = phivPro' * F;
    u0 = zeros(length(kpro), 1);
    v0 = zeros(length(kpro), 1);
    [rvDisPro, ~, ~, ~, ~, ~, ~, ~] = NewmarkBetaReducedMethod...
        (phivPro, mpro, cpro, kpro, fpro, 'average', dt, maxt, u0, v0);
    [Upro, ~, ~, ~, ~, ~, ~, ~] = NewmarkBetaReducedMethod...
        (phiid, M, Cpro, Kpro, F, 'average', dt, maxt, U0, V0);
    
    UerrPro = Upro - phivPro * rvDisPro;
    errPro = norm(UerrPro(qd, qt), 'fro') / canti.dis.norm.trial;
    errProMax(ic) = errProMax(ic) + errPro;
    
    % original.
    phivOri = phiOri(:, 1:nic);
    pmori = [pm1(errOriLoc(ic, 1)) pm2(errOriLoc(ic, 2))];
    Kori =K1 * pmori(1) + K2 * 1;
    Cori = K1 * pmori(2);
    mori = phivOri' * M * phivOri;
    kori = phivOri' * Kori * phivOri;
    cori = phivOri' * Cori * phivOri;
    fori = phivOri' * F;
    [rvDisOri, ~, ~, ~, ~, ~, ~, ~] = NewmarkBetaReducedMethod...
        (phivOri, mori, cori, kori, fori, 'average', dt, maxt, u0, v0);
    [Uori, ~, ~, ~, ~, ~, ~, ~] = NewmarkBetaReducedMethod...
        (phiid, M, Cori, Kori, F, 'average', dt, maxt, U0, V0);
    
    UerrOri = Uori - phivOri * rvDisOri;
    errOri = norm(UerrOri(qd, qt), 'fro') / canti.dis.norm.trial;
    errOriMax(ic) = errOriMax(ic) + errOri;
    
    disp(ic)
end

figure(1)
semilogy(errx, errOriMax, 'b-o', 'MarkerSize', msAll, 'lineWidth', lwAll);
hold on
semilogy(errx, errProMax, 'r-^', 'MarkerSize', msAll, 'lineWidth', lwAll);

xticks(errx);
axis([0 nRb -inf inf]);
axis square
grid on
legend({stStr, proStr}, 'FontSize', fsAll);
set(gca,'fontsize', 20)
xlabel(xLab, 'FontSize', fsAll);
ylabel(yLab, 'FontSize', fsAll);

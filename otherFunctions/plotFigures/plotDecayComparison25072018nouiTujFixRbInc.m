% this script plot results from nouiTuj.

clear; clc; clf;
cd ~/Desktop/Temp/thesisResults/11052018_0935+fixRbInc;
% fix enrichment, trial = 1.
cd trial=129;

load('errOriginalStore.mat', 'errOriginalStore')
load('errProposedStore.mat', 'errProposedStore')
load('errProposedNouiTujN25.mat', 'errProposedNouiTujN25')
load('errRandom1.mat', 'errRandom1')
load('errRandom2.mat', 'errRandom2')
load('errRandom3.mat', 'errRandom3')
load('errRandom4.mat', 'errRandom4')
load('errRandom5.mat', 'errRandom5')
load('errLatin1.mat', 'errLatin1')
load('errLatin2.mat', 'errLatin2')
load('errLatin3.mat', 'errLatin3')
load('errLatin4.mat', 'errLatin4')
load('errLatin5.mat', 'errLatin5')
load('errSobol.mat', 'errSobol')
load('errStruct.mat', 'errStruct')

nPhiIni = 10;
nPhiAdd = 4;
nRb = 50;

errx = (nPhiIni:nPhiAdd:nRb);
errOriMax = errOriginalStore.store.max;
errProMax = errProposedStore.store.max.verify;
errNoMax = errProposedNouiTujN25.store.max.verify;

figure(1)
semilogy(errx, errOriMax, 'b-o', 'MarkerSize', 10, 'lineWidth', 3);
hold on
semilogy(errx, errProMax, 'r-^', 'MarkerSize', 10, 'lineWidth', 3);
semilogy(errx, errNoMax, 'y-v', 'MarkerSize', 10, 'lineWidth', 3);

xticks(errx);
axis([0 nRb errOriMax(end) errOriMax(1)]);
axis normal
grid on
legend({'Standard POD-Greedy', 'Proposed POD-Greedy', 'no uiTuj'}, ...
    'FontSize', 20);
set(gca,'fontsize',20)
xlabel('Total number of basis vectors', 'FontSize', 20);
ylabel('Maximum relative error', 'FontSize', 20);

%% proposed vs pseudorandom.
errRanMax1 = errRandom1.store.realMax;
errRanMax2 = errRandom2.store.realMax;
errRanMax3 = errRandom3.store.realMax;
errRanMax4 = errRandom4.store.realMax;
errRanMax5 = errRandom5.store.realMax;
figure(3)
semilogy(errx, errNoMax, 'y-v', 'MarkerSize', 10, 'lineWidth', 3);
hold on
semilogy(errx, errRanMax1, 'k-.', 'lineWidth', 1.5);
semilogy(errx, errRanMax2, 'k-.', 'lineWidth', 1.5);
semilogy(errx, errRanMax3, 'k-.', 'lineWidth', 1.5);
semilogy(errx, errRanMax4, 'k-.', 'lineWidth', 1.5);
semilogy(errx, errRanMax5, 'k-.', 'lineWidth', 1.5);
xticks(errx);
axis([0 nRb errOriMax(end) errOriMax(1)]);
axis normal
grid on
legend({'Proposed POD-Greedy', 'Pseudorandom'}, 'FontSize', 20);
set(gca,'fontsize',20)
xlabel('Total number of basis vectors', 'FontSize', 20);
ylabel('Maximum relative error', 'FontSize', 20);

%% proposed vs Latin.
errLatinMax1 = errLatin1.store.realMax;
errLatinMax2 = errLatin2.store.realMax;
errLatinMax3 = errLatin3.store.realMax;
errLatinMax4 = errLatin4.store.realMax;
errLatinMax5 = errLatin5.store.realMax;
figure(4)
semilogy(errx, errNoMax, 'y-v', 'MarkerSize', 10, 'lineWidth', 3);
hold on
semilogy(errx, errLatinMax1, 'g--', 'lineWidth', 1.5);
semilogy(errx, errLatinMax2, 'g--', 'lineWidth', 1.5);
semilogy(errx, errLatinMax3, 'g--', 'lineWidth', 1.5);
semilogy(errx, errLatinMax4, 'g--', 'lineWidth', 1.5);
semilogy(errx, errLatinMax5, 'g--', 'lineWidth', 1.5);
xticks(errx);
axis([0 nRb errOriMax(end) errOriMax(1)]);
axis normal
grid on
legend({'Proposed POD-Greedy', 'Latin Hypercube'}, 'FontSize', 20);
set(gca,'fontsize',20)
xlabel('Total number of basis vectors', 'FontSize', 20);
ylabel('Maximum relative error', 'FontSize', 20);

%% proposed vs Sobol.
errSobol = errSobol.store.realMax;
figure(5)
semilogy(errx, errNoMax, 'y-v', 'MarkerSize', 10, 'lineWidth', 3);
hold on
semilogy(errx, errSobol, 'c-*', 'lineWidth', 1.5);
xticks(errx);
axis([0 nRb errOriMax(end) errOriMax(1)]);
axis normal
grid on
legend({'Proposed POD-Greedy', 'Quasi-random (Sobol)'}, 'FontSize', 20);
set(gca,'fontsize',20)
xlabel('Total number of basis vectors', 'FontSize', 20);
ylabel('Maximum relative error', 'FontSize', 20);

%% proposed vs structure.
errStruct = errStruct.store.realMax;
figure(6)
semilogy(errx, errNoMax, 'y-v', 'MarkerSize', 10, 'lineWidth', 3);
hold on
semilogy(errx, errStruct, 'm-+', 'lineWidth', 1.5);
xticks(errx);
axis([0 nRb errOriMax(end) errOriMax(1)]);
axis normal
grid on
legend({'Proposed POD-Greedy', 'Structure'}, 'FontSize', 20);
set(gca,'fontsize',20)
xlabel('Total number of basis vectors', 'FontSize', 20);
ylabel('Maximum relative error', 'FontSize', 20);
clc; clf;
oripath = '~/Desktop/Temp/thesisResults/27052018_1516_GreedyProcedure';
plotData;
load(strcat(oripath, '/greedy/errGreedy.mat'), 'errGreedy');
load(strcat(oripath, '/pseudorandom/errRandom1.mat'), 'errRandom1');
load(strcat(oripath, '/pseudorandom/errRandom2.mat'), 'errRandom2');
load(strcat(oripath, '/pseudorandom/errRandom3.mat'), 'errRandom3');
load(strcat(oripath, '/pseudorandom/errRandom4.mat'), 'errRandom4');
load(strcat(oripath, '/pseudorandom/errRandom5.mat'), 'errRandom5');
load(strcat(oripath, '/structure/errStruct.mat'), 'errStruct');
load(strcat(oripath, '/sobol/errSobol.mat'), 'errSobol');
load(strcat(oripath, '/latin/errLatin1.mat'), 'errLatin1');
load(strcat(oripath, '/latin/errLatin2.mat'), 'errLatin2');
load(strcat(oripath, '/latin/errLatin3.mat'), 'errLatin3');
load(strcat(oripath, '/latin/errLatin4.mat'), 'errLatin4');
load(strcat(oripath, '/latin/errLatin5.mat'), 'errLatin5');

xGreedy = [errGreedy.store.redInfo{2:end, 2}]';
xGreedy = [1; xGreedy];
xSobol = [errSobol.store.redInfo{2:end, 2}]';
xSobol = [1; xSobol];
xRandom = [errRandom1.store.redInfo{2:end, 2}]';
xRandom = [1; xRandom];
xStruct = logspace(-1, 1, 10);
xLatin = [errLatin1.store.redInfo{2:end, 2}]';
xLatin = [1; xLatin];

yAll = zeros(10, 1);
axisHeight = 0.02;

% %%
% figure(1)
% scatter(xGreedy, yAll, scaSize, 'b', 'filled')
% for it = 1:10
%     
%     tLoc = xGreedy(it);
%     tTxt = num2str(it);
%     hold on
%     text(tLoc, 0.002, tTxt, 'Color', 'b', 'FontSize', fsAll);
%     
% end
% axis([0.1 10 -0.001 0.001])
% mp = get(gca, 'Position');
% mp(4) = axisHeight;
% set(gca,'Position',mp)
% grid minor
% set(gca, 'XScale', 'log')
% set(gca, 'YTick', []);
% set(gca,'fontsize',20)
% xlabel('Young''s Modulus', 'FontSize', fsAll);
% 
% %%
% figure(2)
% scatter(xSobol, yAll, scaSize, 'r', 'filled')
% for it = 1:10
%     
%     tLoc = xSobol(it);
%     tTxt = num2str(it);
%     hold on
%     text(tLoc, 0.002, tTxt, 'Color', 'r', 'FontSize', fsAll);
%     
% end
% grid minor
% axis([0.1 10 -0.001 0.001])
% mp = get(gca, 'Position');
% mp(4) = axisHeight;
% set(gca,'Position',mp)
% set(gca, 'XScale', 'log')
% set(gca, 'YTick', []);
% set(gca,'fontsize', fsAll)
% xlabel('Young''s Modulus', 'FontSize', fsAll);
% 
% %%
% figure(3)
% scatter(xRandom, yAll, scaSize, 'k', 'filled')
% for it = 1:10
%     
%     tLoc = xRandom(it);
%     tTxt = num2str(it);
%     hold on
%     text(tLoc, 0.002, tTxt, 'Color', 'k', 'FontSize', fsAll);
%     
% end
% grid minor
% axis([0.1 10 -0.001 0.001])
% mp = get(gca, 'Position');
% mp(4) = axisHeight;
% set(gca,'Position',mp)
% set(gca, 'XScale', 'log')
% set(gca, 'YTick', []);
% set(gca,'fontsize', fsAll)
% xlabel('Young''s Modulus', 'FontSize', fsAll);
% 
% %%
% figure(4)
% scatter(xStruct, yAll, scaSize, 'm', 'filled')
% 
% grid minor
% axis([0.1 10 -0.001 0.001])
% mp = get(gca, 'Position');
% mp(4) = axisHeight;
% set(gca,'Position',mp)
% set(gca, 'XScale', 'log')
% set(gca, 'YTick', []);
% set(gca,'fontsize', fsAll)
% xlabel('Young''s Modulus', 'FontSize', fsAll);

%%
figure(5)
scatter(xLatin, yAll, scaSize, 'g', 'filled')
for it = 1:10
    
    tLoc = xLatin(it);
    tTxt = num2str(it);
    hold on
    text(tLoc, 0.002, tTxt, 'Color', 'g', 'FontSize', fsAll);
    
end
grid minor
axis([0.1 10 -0.001 0.001])
mp = get(gca, 'Position');
mp(4) = axisHeight;
set(gca,'Position',mp)
set(gca, 'XScale', 'log')
set(gca, 'YTick', []);
set(gca,'fontsize', fsAll)
xlabel('Young''s Modulus', 'FontSize', fsAll);
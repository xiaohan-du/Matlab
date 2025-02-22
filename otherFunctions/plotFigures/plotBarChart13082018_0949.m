cd ~/Desktop/Temp/thesisResults/13082018_0949_Ibeam/3146nodes/trial=1/fixrb;

load errProposedNouiTujIter20Add4Profiler.mat;
% profview(0, errProposedNouiTujIter20Add4Profiler)

load errOriginalIter20Add4Profiler.mat
% profview(0, errOriginalIter20Add4Profiler)

% original: pm sweep = NM, basis processing.
% proposed: impulse response = NM, construct Wa, pm sweep, basis processing.
% proposed.
tpall = 63752; % total
tpNM = 14122; % exact solution
tpMTM = 48066;
tpSweep = 452 + 239;
tpRB = tpall - tpNM - tpMTM - tpSweep;

toRB = 10609 - 10193;
toNMsweep = 10193;
ttNMsweep = toNMsweep / 1620 * 1089 * 20;
plotData;

tall = [ toRB toNMsweep   0 0;  toRB ttNMsweep   0 0; tpRB tpSweep tpNM tpMTM ];

h = barh(tall, 'stacked');
set(h, {'facecolor'}, {'b'; 'r'; 'y'; 'g'})
axis normal
grid on
legend('Basis generation', 'Parameter sweep', 'Computation of U^{imp}', ...
    'Computation of M_i^{trans}', 'Interpreter', 'latex', 'Location', 'southeast')
set(gca,'fontsize', fsAll)
set(gca,'xscale','log')
xlabel('Execution time (seconds)', 'FontSize', fsAll)
xlim([100, 150000])

% data1a = 63752; % total
% data1b = 14122; % exact solution
% data1c = 48066 - 239;
% data1d = 452 + 239;
% data1e = data1a - data1b - data1c - data1d;
% 
% data2b = 10609 - 10193;
% data2d = 10193;
% data3 = data2d / 1620 * 1089 * 20;
% plotData;
% 
% dataAll = [ data2b data2d 0 0;  data2b data3 0 0;  data1b data1d data1e data1c ];
% 
% h = barh(dataAll, 'stacked');
% % set(h, {'facecolor'}, {'b'; 'y'})
% % axis normal
% % grid on
% % legend('Basis generation', 'Parameter sweep')
% % set(gca,'fontsize', fsAll)
% set(gca,'xscale','log')
% % xlabel('Execution time (seconds)', 'FontSize', fsAll)
% % axis auto
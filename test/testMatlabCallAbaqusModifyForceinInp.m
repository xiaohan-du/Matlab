clear; clc;
% this script tests modifying force input of .inp file, 
%% part I: solve the parametric problem using Abaqus, read the output.
% set up the model informations.
nnode = 517;
node = (1:nnode)';
nodeFix = [3 4 7 8 36:44 88:96]';
node(nodeFix) = [];
nnodeFree = length(node);
dofFix = sort([nodeFix * 2; nodeFix * 2 - 1]);
dof = (1:2 * nnode)';
dof(dofFix) = [];
ndofFree = length(dof);
dT = 0.1;
maxT = 4.9;
nd = 1034;
nt = length(0:dT:maxT);

% set up the unmodified inps.
jobDef = '/home/xiaohan/abaqus/6.14-1/code/bin/abq6141 noGUI job=';
abaqusPath = '/home/xiaohan/Desktop/Temp/AbaqusModels';
inpNameUnmo = 'l9h2SingleInc_forceMod';
inpPathUnmo = [abaqusPath '/fixBeam/'];

% set up the output .dat file path, same path for all output files.
iterStr = '_iter';
datName = [inpNameUnmo iterStr];
inpPathMo = [abaqusPath '/iterModels/'];

% read the original unmodified .inp file.
inpTextUnmo = fopen([inpPathUnmo, inpNameUnmo, '.inp']);
rawInpStr = textscan(inpTextUnmo, '%s', 'delimiter', '\n', 'whitespace', '');
fclose(inpTextUnmo);

% find the force part to be modified in .inp file.

fceStr = {'*Nset, nset=Set-af'; '*Nset, nset=Set-lc'; '*Amplitude'; ...
    '** MATERIALS'; '*Cload, amplitude'; '** OUTPUT REQUESTS'};

fceStrLoc = zeros(length(fceStr), 1);

for iFce = 1:length(fceStr)
    
    fceStrLoc(iFce) = find(strncmp(rawInpStr{1}, ...
        fceStr{iFce}, length(fceStr{iFce})));
    
end

% import the external force for each dof.
load('/home/xiaohan/Desktop/Temp/AbaqusModels/iterModels/fce.mat', 'fce')
% modify part of the inp file where force is defined.
fceAba = fce(:, 1:nt);
fceAmp = zeros(nd, 2 * nt);
fceAmp(:, 1:2:end) = fceAmp(:, 1:2:end) + repmat((0:dT:maxT), [nd, 1]);
fceAmp(:, 2:2:end) = fceAmp(:, 2:2:end) + fceAba;
% write the force information into new .inp file.
setCell = [];
cloadCell = [];
for iNode = 1:nnode
    setStr = ['*Nset, nset=Set-af' num2str(iNode) ', instance=beam-1'];
    setCell_ = {setStr; num2str(iNode)};
    setCell = [setCell; setCell_];
    cload1 = ['*Cload, amplitude=Amp-af' num2str(iNode * 2 - 1)];
    cload2 = ['Set-af' num2str(iNode) ', 1, 1'];
    cload3 = ['*Cload, amplitude=Amp-af' num2str(iNode * 2)];
    cload4 = ['Set-af' num2str(iNode) ', 2, 1'];
    cloadCell = [cloadCell; {cload1; cload2; cload3; cload4}];
    
end
nline = floor(nt * 2 / 8);
ampCell = [];
for iDof = 1:nnode * 2
    ampStr = {['*Amplitude, name=Amp-af' num2str(iDof)]};
    ampVal = fceAmp(iDof, :);
    ampInsLine1 = ampVal(1:nline * 8);
    ampInsLine1 = reshape(ampInsLine1, [8, nline]);
    ampInsCell1 = mat2cell(ampInsLine1', ones(1, nline), 8);
    ampInsCell1 = cellfun(@(v) num2str(v), ampInsCell1, 'un', 0);
    ampInsCell2 = {num2str(ampVal(length(ampVal(1:nline * 8)) + 1:end))};
    ampInsCell = [ampInsCell1; ampInsCell2];
    ampInsCell = regexprep(ampInsCell,'(\d)(?=( |$))','$1,');
    ampCell = [ampCell; ampStr; ampInsCell];
end

% set the text file to be written.
% .inp file structure: 
% 1. Beginning to *End Instance (1 - 1498);
% 2. Set-af part;
% 3. *Nset, nset=Set-lc to *End Assembly (1500 - 1508);
% 4. Amp part;
% 5. ** MATERIALS to ** Name: Load-af   Type: Concentrated force (1513 - 1548);
% 6. Cload part;
% 7. ** OUTPUT REQUESTS to end (1552 - 1560).
rawInpStr{1} = [rawInpStr{1}(1:fceStrLoc(1) - 1);...
    setCell; ...
    rawInpStr{1}(fceStrLoc(2):fceStrLoc(3) - 1); ...
    ampCell; ...
    rawInpStr{1}(fceStrLoc(4):fceStrLoc(5) - 1);...
    cloadCell; ...
    rawInpStr{1}(fceStrLoc(6):end)];

% modified .inp file name.
inpNameMo = [inpNameUnmo, iterStr];
% print the modified .inp file to the output path.
fid = fopen([inpPathMo inpNameMo, '.inp'], 'wt');
fprintf(fid, '%s\n', string(rawInpStr{1}));
fclose(fid);
% run Abaqus for each pm value.
cd(inpPathMo)
runStr = strcat(jobDef, inpNameMo, ' inp=', inpPathMo, ...
    inpNameMo, '.inp interactive ask_delete=OFF');
system(runStr);
%% 
% read the .dat file.
datText = fopen([inpPathMo, datName, '.dat']);
rawDatStr = textscan(datText, '%s', 'delimiter', '\n', 'whitespace', '');
fclose(datText);

% locate the strings to be modified.
datStrStart = 'THE FOLLOWING TABLE IS PRINTED FOR';
datStrEnd = 'AT NODE';
lineIstrStart = [];
lineStrEnd = [];

for iStr = 1:length(rawDatStr{1})
    % define string to compare.
    datStrComp = strtrim(rawDatStr{1}{iStr});
    % compare the start string for nodal output.
    if length(datStrComp) > 33
        datStrCompStart = datStrComp(1:34);
        if strcmp(datStrCompStart, datStrStart) == 1
            lineIstrStart = [lineIstrStart; iStr];
        end
    end
    % compare the end string for nodal output.
    if length(datStrComp) > 6
        datStrCompEnd = datStrComp(1:7);
        if strcmp(datStrCompEnd, datStrEnd) == 1
            lineStrEnd = [lineStrEnd; iStr];
        end
    end
end

% find the locations of displacement outputs.
lineModStart = lineIstrStart + 5;
lineModEnd = lineStrEnd(1:2:end) - 3;

% transform and store the displacement outputs.
disAllStore = cell(length(lineModStart), 1);
for iDis = 1:length(lineModStart)
    
    dis_ = rawDatStr{1}(lineModStart(iDis) : lineModEnd(iDis));
    dis_ = str2num(cell2mat(dis_));
    % fill non-exist spots with 0s.
    if size(dis_, 1) ~= nnode
        
        disAllDof = zeros(nnode, 3);
        disAllDof(dis_(:, 1), :) = dis_;
        disAllDof(:, 1) = (1:nnode);
    end
    disAllStore(iDis) = {disAllDof};
    
end
% reshape these u1 u2 displacements to standard space-time vectors, first
% extract displacements without indices.
disValStore = cellfun(@(v) v(:, 2:3), disAllStore, 'un', 0);
disVecStore = cellfun(@(v) v', disValStore, 'un', 0);
disVecStore = cellfun(@(v) v(:), disVecStore, 'un', 0);

dis = cell2mat(disVecStore');

%% how to check the results obtained from invoking Abaqus?
% set the pm values for inclusion and matrix the same as the trial values of
% callFixieOriginal, run this test first, obtain norm(disValStore, 'fro'),
% then run callFixieOriginal, obtain norm(fixie.dis.trial, 'fro').

% read mas matrix.
masMtxFile = [abaqusPath, '/iterModels/', inpNameUnmo, '_iter_MASS1.mtx'];
ASM = dlmread(masMtxFile);
indI = zeros(length(ASM), 1);
indJ = zeros(length(ASM), 1);
Node_n = max(ASM(:,1));    %or max(ASM(:,3))
ndof = Node_n * 2;
for ii = 1:size(ASM,1)
    indI(ii) = 2 * (ASM(ii,1)-1) + ASM(ii,2);
    indJ(ii) = 2 * (ASM(ii,3)-1) + ASM(ii,4);
end

M = sparse(indI, indJ, ASM(:, 5), ndof, ndof);

masMtx = M' + M;

for i_tran = 1:length(M)
    masMtx(i_tran, i_tran) = masMtx(i_tran, i_tran) / 2;
end

% read stiffness matrix.
stiMtxFile = [abaqusPath, '/iterModels/', inpNameUnmo, '_iter_STIF1.mtx'];
ASM = dlmread(stiMtxFile);

for ii=1:size(ASM, 1)
    indI(ii) = 2 * (ASM(ii,1)-1) + ASM(ii,2);
    indJ(ii) = 2 * (ASM(ii,3)-1) + ASM(ii,4);
end

M = sparse(indI,indJ,ASM(:, 5),ndof, ndof);
stiMtx = M' + M;

for i_tran=1:length(M)
    stiMtx(i_tran, i_tran) = stiMtx(i_tran, i_tran) / 2;
end

diagindx = (dofFix - 1) * (ndof + 1) + 1;
stiMtx(dofFix, :) = 0;
stiMtx(:, dofFix) = 0;
stiMtx(diagindx) = 1;

u0 = zeros(nnode * 2, 1);
v0 = zeros(nnode * 2, 1);
phi = eye(nnode * 2);

[~, ~, ~, u, ~, ~, ~, ~] = NewmarkBetaReducedMethod...
    (phi, masMtx, zeros(nnode * 2), stiMtx, fce, ...
    'average', dT, maxT, u0, v0);

%% plot the first N displacements with subplot.
xAba = 0.1:dT:maxT;
xMat = 0:dT:maxT;
clf;
figure(1)
for iPlot = 500:503
    subplot(2, 2, iPlot - 499)
    plot(xAba, dis(iPlot, :), '-^', 'LineWidth', 1);
    hold on
    plot(xMat, u(iPlot, :), '-*', 'LineWidth', 1)
    legend('abaqus', 'matlab')
    grid minor
end
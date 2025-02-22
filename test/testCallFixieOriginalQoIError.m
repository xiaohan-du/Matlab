%% compute exact solution.
pmI = 0.10746;
pmS = 1;
stiI = fixie.sti.mtxCell{1};
stiS = fixie.sti.mtxCell{2};
sti = stiI * pmI + stiS * pmS;
mas = fixie.mas.mtx;
dam = fixie.dam.mtx;

fce = fixie.fce.val;
nd = fixie.no.dof;
phiIdent = eye(nd);

maxT = fixie.time.max;
dT = fixie.time.step;
u0 = fixie.dis.inpt;
v0 = fixie.vel.inpt;
fce = [fce zeros(nd, 20)];
[~, ~, ~, u, ~, ~, ~, ~] = NewmarkBetaReducedMethod...
    (phiIdent, mas, dam, sti, fce, 'average', dT, 8.9, u0, v0);

%% compute solution from reduced model.
stiIr = fixie.phi.val' * stiI * fixie.phi.val;
stiSr = fixie.phi.val' * stiS * fixie.phi.val;
stir = stiIr * pmI + stiSr * pmS;

masr = fixie.phi.val' * mas * fixie.phi.val;
damr = fixie.phi.val' * dam * fixie.phi.val;

fcer = fixie.phi.val' * fce;
phi = fixie.phi.val;
u0r = fixie.dis.re.inpt;
v0r = fixie.vel.re.inpt;

[disrv, ~, ~, ~, ~, ~, ~, ~] = NewmarkBetaReducedMethod...
    (phi, masr, damr, stir, fcer, 'average', dT, 8.9, u0r, v0r);

ur = phi * disrv;

%% include QoI and calculate error.
qoiDof = fixie.qoi.dof;
qoiT = fixie.qoi.t;
uq = u(qoiDof, qoiT);
urq = ur(qoiDof, qoiT);
% uq = u;
% urq = ur;
err = norm((uq - urq), 'fro') / norm(fixie.dis.qoi.trial, 'fro');
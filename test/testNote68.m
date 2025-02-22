clear; clc;
% this script tests note 68 for 2d Lagrange interpolation.
z1 = [1 2; 3 4; 5 6];
z2 = [8 7; 6 5; 4 3];
z3 = [3 4; 3 2; 1 5];
z4 = [5 6; 8 9; 4 7];

inptx = 0.5;
inpty = -0.5;
xl = -1;
xr = 1;
yl = -1;
yr = 1;
[gridx, gridy] = meshgrid([xl xr], [yl yr]);
gridz = {z1 z2; z3 z4};
%% interpolate u.
% case 1: interpolate in 2d.
[cf1, cf2, otpt] = LagrangeInterpolation2D(inptx, inpty, gridx, gridy, gridz);
% case 2: interpolate in x, then y, see if the coefficients are correct.
xco1d = {-1 1}; % 1d = x direction.
zco1d12 = {z1; z2};
[cf1d, otpt1d12] = lagrange(inptx, xco1d, zco1d12);
zco1d34 = {z3; z4};
[~, otpt1d34] = lagrange(inptx, xco1d, zco1d34);

yco2d = {-1 1}; % 2d = y direction.
zco2d = {otpt1d12; otpt1d34};
[cf2d, otpt2d] = lagrange(inpty, yco2d, zco2d);

% case 3: use coeffs to directly perform 2d interpolation. 
% (get the intersected coeffs (cfcf12), then multiply with each matrix).
cfcf12 = cf1d * cf2d';

otpt_ = z1 * cfcf12(1, 1) + z2 * cfcf12(2, 1) + ...
    z3 * cfcf12(1, 2) + z4 * cfcf12(2, 2);
%% interpolate uTu.
% case 4: interpolate then take uTu.
uTu1 = otpt' * otpt;

% case 5: uTu then interpolate.
cfcf1212_ = cfcf12(:) * (cfcf12(:))';
% always 10 components when there are 4 itpl samples. 
% dimension of each components = no of columns of pre-computed displacements.
z11 = z1' * z1;
z22 = z2' * z2;
z33 = z3' * z3;
z44 = z4' * z4;
z12 = z1' * z2;
z13 = z1' * z3;
z14 = z1' * z4;
z23 = z2' * z3;
z24 = z2' * z4;
z34 = z3' * z4;
z0 = zeros(length(z11));

zcell = {z11 z12 z13 z14; z0 z22 z23 z24; ...
    z0 z0 z33 z34; z0 z0 z0 z44};
% process cfcf1212, make the non-diagonal elements double. 
cfcf1212 = zeros(4);

for i = 1:4
    for j = i:4
        if i == j
            cfcf1212(i, j) = cfcf1212(i, j) + cfcf1212_(i, j);
        else
            cfcf1212(i, j) = cfcf1212(i, j) + 2 * cfcf1212_(i, j);
        end
    end
end

cfcell = num2cell(cfcf1212);

uTu2_ = cellfun(@(u, v) u * v, zcell, cfcell, 'un', 0);
uTu2 = sum(cat(3,uTu2_{:}),3);
uTu2 = (uTu2 + uTu2') / 2;

%% include projection on rvs.
rv = [1 2; 4 5];
% case 6: interpolate then project.
uTu1p = rv' * uTu1 * rv;
% case 7: project then interpolate.
z11p = rv' * z11 * rv;
z12p = rv' * z12 * rv;
z13p = rv' * z13 * rv;
z14p = rv' * z14 * rv;
z22p = rv' * z22 * rv;
z23p = rv' * z23 * rv;
z24p = rv' * z24 * rv;
z33p = rv' * z33 * rv;
z34p = rv' * z34 * rv;
z44p = rv' * z44 * rv;
z0p = rv' * z0 * rv;
zpcell = {z11p z12p z13p z14p; z0p z22p z23p z24p; ...
    z0p z0p z33p z34p; z0p z0p z0p z44p};
uTu2p_ = cellfun(@(u, v) u * v, zpcell, cfcell, 'un', 0);
uTu2p = sum(cat(3,uTu2p_{:}),3);
uTu2p = (uTu2p + uTu2p') / 2;
clear variables; clc;

a = [1:12; 3:14; 5:16; 2:13];
%%
[x, y, z] = svd(a, 0); % thin svd

no.nrb = 2;

bl = x(:, 1:no.nrb);
sig = y(1:no.nrb, 1:no.nrb);
blsig = x(:, 1:no.nrb) * y(1:no.nrb, 1:no.nrb);
br = z(:, 1:no.nrb);

recons = blsig * br';


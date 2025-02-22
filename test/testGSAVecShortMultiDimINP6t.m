clear variables; clc;
no_dof = 4;
no_rb = 3;
no_phy = 5;
no_t = 6;

no_zeros = zeros(1, no_dof);

solf = 1:20;
f = [no_zeros solf]';
%%
% a = cell(pre, rb, phy, time);
a = cell(1, no_rb, no_phy, no_t);

sol1 = 2:21;

sol2 = -1:18;

a{1, 1, 1, 1} = [no_zeros sol1]';

a{1, 1, 1, 2} = [no_zeros sol2]';

a{1, 1, 1, 3} = [zeros(1, 8) sol2(1:16)]';

a{1, 1, 1, 4} = [zeros(1, 12) sol2(1:12)]';

a{1, 1, 1, 5} = [zeros(1, 16) sol2(1:8)]';

a{1, 1, 1, 6} = [zeros(1, 20) sol2(1:4)]';

sol3 = -2:17;

sol4 = -3:16;

a{1, 2, 1, 1} = [no_zeros sol3]';

a{1, 2, 1, 2} = [no_zeros sol4]';

a{1, 2, 1, 3} = [zeros(1, 8) sol4(1:16)]';

a{1, 2, 1, 4} = [zeros(1, 12) sol4(1:12)]';

a{1, 2, 1, 5} = [zeros(1, 16) sol4(1:8)]';

a{1, 2, 1, 6} = [zeros(1, 20) sol4(1:4)]';

sol5 = -4:15;

sol6 = -5:14;

a{1, 3, 1, 1} = [no_zeros sol5]';

a{1, 3, 1, 2} = [no_zeros sol6]';

a{1, 3, 1, 3} = [zeros(1, 8) sol6(1:16)]';

a{1, 3, 1, 4} = [zeros(1, 12) sol6(1:12)]';

a{1, 3, 1, 5} = [zeros(1, 16) sol6(1:8)]';

a{1, 3, 1, 6} = [zeros(1, 20) sol6(1:4)]';

sol7 = -6:13;

sol8 = -7:12;

a{1, 1, 2, 1} = [no_zeros sol7]';

a{1, 1, 2, 2} = [no_zeros sol8]';

a{1, 1, 2, 3} = [zeros(1, 8) sol8(1:16)]';

a{1, 1, 2, 4} = [zeros(1, 12) sol8(1:12)]';

a{1, 1, 2, 5} = [zeros(1, 16) sol8(1:8)]';

a{1, 1, 2, 6} = [zeros(1, 20) sol8(1:4)]';

sol9 = -8:11;

sol10 = -9:10;

a{1, 2, 2, 1} = [no_zeros sol9]';

a{1, 2, 2, 2} = [no_zeros sol10]';

a{1, 2, 2, 3} = [zeros(1, 8) sol10(1:16)]';

a{1, 2, 2, 4} = [zeros(1, 12) sol10(1:12)]';

a{1, 2, 2, 5} = [zeros(1, 16) sol10(1:8)]';

a{1, 2, 2, 6} = [zeros(1, 20) sol10(1:4)]';

sol11 = -10:9;

sol12 = -11:8;

a{1, 3, 2, 1} = [no_zeros sol11]';

a{1, 3, 2, 2} = [no_zeros sol12]';

a{1, 3, 2, 3} = [zeros(1, 8) sol12(1:16)]';

a{1, 3, 2, 4} = [zeros(1, 12) sol12(1:12)]';

a{1, 3, 2, 5} = [zeros(1, 16) sol12(1:8)]';

a{1, 3, 2, 6} = [zeros(1, 20) sol12(1:4)]';

sol13 = -12:7;

sol14 = -13:6;

a{1, 1, 3, 1} = [no_zeros sol13]';

a{1, 1, 3, 2} = [no_zeros sol14]';

a{1, 1, 3, 3} = [zeros(1, 8) sol14(1:16)]';

a{1, 1, 3, 4} = [zeros(1, 12) sol14(1:12)]';

a{1, 1, 3, 5} = [zeros(1, 16) sol14(1:8)]';

a{1, 1, 3, 6} = [zeros(1, 20) sol14(1:4)]';

sol15 = -14:5;

sol16 = -15:4;

a{1, 2, 3, 1} = [no_zeros sol15]';

a{1, 2, 3, 2} = [no_zeros sol16]';

a{1, 2, 3, 3} = [zeros(1, 8) sol16(1:16)]';

a{1, 2, 3, 4} = [zeros(1, 12) sol16(1:12)]';

a{1, 2, 3, 5} = [zeros(1, 16) sol16(1:8)]';

a{1, 2, 3, 6} = [zeros(1, 20) sol16(1:4)]';

sol17 = -16:3;

sol18 = -17:2;

a{1, 3, 3, 1} = [no_zeros sol17]';

a{1, 3, 3, 2} = [no_zeros sol18]';

a{1, 3, 3, 3} = [zeros(1, 8) sol18(1:16)]';

a{1, 3, 3, 4} = [zeros(1, 12) sol18(1:12)]';

a{1, 3, 3, 5} = [zeros(1, 16) sol18(1:8)]';

a{1, 3, 3, 6} = [zeros(1, 20) sol18(1:4)]';

sol19 = -18:1;

sol20 = -19:0;

a{1, 1, 4, 1} = [no_zeros sol19]';

a{1, 1, 4, 2} = [no_zeros sol20]';

a{1, 1, 4, 3} = [zeros(1, 8) sol20(1:16)]';

a{1, 1, 4, 4} = [zeros(1, 12) sol20(1:12)]';

a{1, 1, 4, 5} = [zeros(1, 16) sol20(1:8)]';

a{1, 1, 4, 6} = [zeros(1, 20) sol20(1:4)]';

sol21 = 3:22;

sol22 = 4:23;

a{1, 2, 4, 1} = [no_zeros sol21]';

a{1, 2, 4, 2} = [no_zeros sol22]';

a{1, 2, 4, 3} = [zeros(1, 8) sol22(1:16)]';

a{1, 2, 4, 4} = [zeros(1, 12) sol22(1:12)]';

a{1, 2, 4, 5} = [zeros(1, 16) sol22(1:8)]';

a{1, 2, 4, 6} = [zeros(1, 20) sol22(1:4)]';

sol23 = 5:24;

sol24 = 6:25;

a{1, 3, 4, 1} = [no_zeros sol23]';

a{1, 3, 4, 2} = [no_zeros sol24]';

a{1, 3, 4, 3} = [zeros(1, 8) sol24(1:16)]';

a{1, 3, 4, 4} = [zeros(1, 12) sol24(1:12)]';

a{1, 3, 4, 5} = [zeros(1, 16) sol24(1:8)]';

a{1, 3, 4, 6} = [zeros(1, 20) sol24(1:4)]';


sol25 = 7:26;

sol26 = 8:27;

a{1, 1, 5, 1} = [no_zeros sol25]';

a{1, 1, 5, 2} = [no_zeros sol26]';

a{1, 1, 5, 3} = [zeros(1, 8) sol26(1:16)]';

a{1, 1, 5, 4} = [zeros(1, 12) sol26(1:12)]';

a{1, 1, 5, 5} = [zeros(1, 16) sol26(1:8)]';

a{1, 1, 5, 6} = [zeros(1, 20) sol26(1:4)]';

sol27 = 9:28;

sol28 = 10:29;

a{1, 2, 5, 1} = [no_zeros sol27]';

a{1, 2, 5, 2} = [no_zeros sol28]';

a{1, 2, 5, 3} = [zeros(1, 8) sol28(1:16)]';

a{1, 2, 5, 4} = [zeros(1, 12) sol28(1:12)]';

a{1, 2, 5, 5} = [zeros(1, 16) sol28(1:8)]';

a{1, 2, 5, 6} = [zeros(1, 20) sol28(1:4)]';

sol29 = 11:30;

sol30 = 12:31;

a{1, 3, 5, 1} = [no_zeros sol29]';

a{1, 3, 5, 2} = [no_zeros sol30]';

a{1, 3, 5, 3} = [zeros(1, 8) sol30(1:16)]';

a{1, 3, 5, 4} = [zeros(1, 12) sol30(1:12)]';

a{1, 3, 5, 5} = [zeros(1, 16) sol30(1:8)]';

a{1, 3, 5, 6} = [zeros(1, 20) sol30(1:4)]';

%%

b = cell(1, no_rb, no_phy, 2);

b{1, 1, 1, 1} = a{1, 1, 1, 1};

b{1, 1, 1, 2} = a{1, 1, 1, 2};

b{1, 2, 1, 1} = a{1, 2, 1, 1};

b{1, 2, 1, 2} = a{1, 2, 1, 2};

b{1, 3, 1, 1} = a{1, 3, 1, 1};

b{1, 3, 1, 2} = a{1, 3, 1, 2};


b{1, 1, 2, 1} = a{1, 1, 2, 1};

b{1, 1, 2, 2} = a{1, 1, 2, 2};

b{1, 2, 2, 1} = a{1, 2, 2, 1};

b{1, 2, 2, 2} = a{1, 2, 2, 2};

b{1, 3, 2, 1} = a{1, 3, 2, 1};

b{1, 3, 2, 2} = a{1, 3, 2, 2};


b{1, 1, 3, 1} = a{1, 1, 3, 1};

b{1, 1, 3, 2} = a{1, 1, 3, 2};

b{1, 2, 3, 1} = a{1, 2, 3, 1};

b{1, 2, 3, 2} = a{1, 2, 3, 2};

b{1, 3, 3, 1} = a{1, 3, 3, 1};

b{1, 3, 3, 2} = a{1, 3, 3, 2};


b{1, 1, 4, 1} = a{1, 1, 4, 1};

b{1, 1, 4, 2} = a{1, 1, 4, 2};

b{1, 2, 4, 1} = a{1, 2, 4, 1};

b{1, 2, 4, 2} = a{1, 2, 4, 2};

b{1, 3, 4, 1} = a{1, 3, 4, 1};

b{1, 3, 4, 2} = a{1, 3, 4, 2};


b{1, 1, 5, 1} = a{1, 1, 5, 1};

b{1, 1, 5, 2} = a{1, 1, 5, 2};

b{1, 2, 5, 1} = a{1, 2, 5, 1};

b{1, 2, 5, 2} = a{1, 2, 5, 2};

b{1, 3, 5, 1} = a{1, 3, 5, 1};

b{1, 3, 5, 2} = a{1, 3, 5, 2};
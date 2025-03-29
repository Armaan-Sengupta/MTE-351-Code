clear all;
clc;
close all;

M = 35;
Mu = 50 + 1/2;
I_Gw = 0.02;
R = (12.7)/100;
L_g = 1;
I_Gu = 20;
g = 9.81;
beta = 0.2;
Ft = 170.203;


C1 = M + Mu + (I_Gw / R^2);
C2 = L_g * Mu;                     % cos(beta) ≈ 1    % sin(beta) ≈ (theta + beta)
C4 = (Mu * L_g^2 + I_Gu);
C7 = 1; % Given

% Defining constant A:
A = 1 / (C1 + (C2 * g / C4));

% Defining constant B:
B = (C2 * g) / (C4 * C1 + C2 * g);

% Defining constant C:
C = C2 / (C4 * C1 + C2^2);

% Defining constant D:
D = (C2 * g) / (C4 + (C2^2 / C1));

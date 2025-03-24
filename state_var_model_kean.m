clear; clc;
syms x1 x2 x3 x4 u beta C1 C2 C4 C5 M_u L_g g x_dot x_ddot theta_dot theta_ddot u M Mu I_Gw I_Gu R L_g g beta theta

USE_EXPR_FOR_CONSTANTS = true; %change to false to get in terms of C1...C7 or to true to get expanded version

if USE_EXPR_FOR_CONSTANTS
    % Define small-angle approximated coefficients
    C1 = M + Mu + (I_Gw / R^2);
    C2 = L_g * Mu;                     % cos(beta) ≈ 1    % sin(beta) ≈ (theta + beta)
    C4 = (Mu * L_g^2 + I_Gu);
    C5 = Mu * L_g;                      % cos(beta) ≈ 1
    C6 = -Mu * g * L_g * (theta + beta); % sin(beta) ≈ (theta + beta)
    C7 = 1; % Given
else
    syms C1 C2 C4 C5 C6 C7;
end

% Define state vector
X = [x1; x2; x3; x4];

% Define A matrix
A = [0, 1, 0, 0;
     0, 0, (C2 * L_g * M_u * g) / (C1 * C4 - C2 * C5), 0;
     0, 0, 0, 1;
     0, 0, (-C1 * L_g * M_u * g) / (C1 * C4 - C2 * C5), 0];

% Define B matrix
B = [0, 0;
     (C4) / (C1 * C4 - C2 * C5), (C2 * L_g * M_u * g) / (C1 * C4 - C2 * C5);
     0, 0;
     (-C5) / (C1 * C4 - C2 * C5), (-C1 * L_g * M_u * g) / (C1 * C4 - C2 * C5)];

% Convert matrices to LaTeX format
A_latex = ['$ A = ', latex(A), ' $'];
B_latex = ['$ B = ', latex(B), ' $'];

% Display in Command Window
disp('A Matrix:');
disp(A);
disp('B Matrix:');
disp(B);

% Display LaTeX equations in MATLAB figure
figure;
text(0.1, 0.7, A_latex, 'Interpreter', 'latex', 'FontSize', 20);
text(0.1, 0.3, B_latex, 'Interpreter', 'latex', 'FontSize', 20);
title('State-Space Matrices in LaTeX', 'Interpreter', 'latex', 'FontSize', 16);
axis off;

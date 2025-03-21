clear; clc;
syms x1 x2 x3 x4 u beta C1 C2 C4 C5 M_u L_g g

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

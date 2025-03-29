clear; clc;
syms x_ddot theta_ddot u beta x3 C1 C2 C4 C5 C6 M_u L_g g

% Define C6 in terms of x3 (theta) and beta
C6 = -M_u * g * L_g * (x3 + beta);

% Given system of equations (from first picture)
theta_ddot_expr = (C1 * C6 - C5 * u) / (C1 * C4 - C2 * C5);
x_ddot_expr = -(C2 * C6 - C4 * u) / (C1 * C4 - C2 * C5);

% Substitute C6 into the equations
theta_ddot_expanded = simplify(expand(subs(theta_ddot_expr, C6, -M_u * g * L_g * (x3 + beta))));
x_ddot_expanded = simplify(expand(subs(x_ddot_expr, C6, -M_u * g * L_g * (x3 + beta))));

% Generate LaTeX equations
eq1_latex = ['$ \ddot{x} = ', latex(x_ddot_expanded), ' $'];
eq2_latex = ['$ \ddot{\theta} = ', latex(theta_ddot_expanded), ' $'];

% Display LaTeX equations in MATLAB figure
figure;
text(0.1, 0.5, eq1_latex, 'Interpreter', 'latex', 'FontSize', 24);
text(0.1, 0.8, eq2_latex, 'Interpreter', 'latex', 'FontSize', 24);
title('Expanded Linearized System Equations in LaTeX', 'Interpreter', 'latex', 'FontSize', 16);
axis off;

% Display in command window
disp('Expanded Equations:');
disp('x_ddot = ');
pretty(x_ddot_expanded);
disp('theta_ddot = ');
pretty(theta_ddot_expanded);

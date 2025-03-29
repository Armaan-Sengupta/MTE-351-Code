clear all;
clc;
close all;

syms x_dot x_ddot theta_dot theta_ddot u M Mu I_Gw I_Gu R L_g g beta theta

USE_EXPR_FOR_CONSTANTS = false; %change to false to get in terms of C1...C7 or to true to get expanded version

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
% Given system of equations
eq1 = C1*x_ddot + C2*theta_ddot == u;
eq2 = C4*theta_ddot + C5*x_ddot - C6 == 0;

% Solve eq1 for x_ddot and eq2 for theta_ddot
x_ddot_isolated = solve(eq1, x_ddot);
theta_ddot_isolated = solve(eq2, theta_ddot);

% Substitute theta_ddot_isolated into x_ddot_isolated
x_ddot_substituted = x_ddot == simplify(subs(x_ddot_isolated, theta_ddot, theta_ddot_isolated));

% Substitute x_ddot_isolated into theta_ddot_isolated
theta_ddot_substituted = theta_ddot == simplify(subs(theta_ddot_isolated, x_ddot, x_ddot_isolated));



x_ddot_sub_isolated = solve(x_ddot_substituted, x_ddot);
theta_ddot_sub_isolated = solve(theta_ddot_substituted, theta_ddot);

% Construct LaTeX equations explicitly including the left-hand side
eq1_latex = ['$ \ddot{x} = ', latex(x_ddot_sub_isolated), ' $'];
eq2_latex = ['$ \ddot{\theta} = ', latex(theta_ddot_sub_isolated), ' $'];

% Display equations in figure with LaTeX rendering
figure;
text(0.1, 0.5, eq1_latex, 'Interpreter', 'latex', 'FontSize', 24);
text(0.1, 0.8, eq2_latex, 'Interpreter', 'latex', 'FontSize', 24);
title('Linearized System Equations in LaTeX', 'Interpreter', 'latex', 'FontSize', 16);
axis off;


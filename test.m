clear all;
clc;
close all;

syms x_ddot theta_ddot u M Mu I_Gw I_Gu R Lg g beta

USE_EXPR_FOR_CONSTANTS = false;

if USE_EXPR_FOR_CONSTANTS
        % Define coefficients based on given approximations
    C1 = M + Mu + (I_Gw / R^2);
    C2 = Lg * Mu * cos(beta);
    C3 = -Mu * Lg * sin(beta);
    C4 = (Mu * Lg^2 + I_Gu);
    C5 = Mu * Lg * cos(beta);
    C6 = -Mu * g * Lg * sin(beta);
    C7 = 1; % Given as 1
else
    syms C1 C2 C3 C4 C5 C6 C7;
end
% Given system of equations
eq1 = C1*x_ddot + C2*theta_ddot - C3*theta_ddot^2 == C7*u;
eq2 = C4*theta_ddot + C5*x_ddot - C6 == 0;

% Solve eq1 for x_ddot and eq2 for theta_ddot
x_ddot_isolated = solve(eq1, x_ddot)
theta_ddot_isolated = solve(eq2, theta_ddot)

% Substitute theta_ddot_isolated into x_ddot_isolated
x_ddot_substituted = simplify(subs(x_ddot_isolated, theta_ddot, theta_ddot_isolated));

% Substitute x_ddot_isolated into theta_ddot_isolated
theta_ddot_substituted = simplify(subs(theta_ddot_isolated, x_ddot, x_ddot_isolated));

% Construct LaTeX equations explicitly including the left-hand side
eq1_latex = ['$ \ddot{x} = ', latex(x_ddot_substituted), ' $'];
eq2_latex = ['$ \ddot{\theta} = ', latex(theta_ddot_substituted), ' $'];

% Display equations in figure with LaTeX rendering
figure;
text(0.1, 0.5, eq1_latex, 'Interpreter', 'latex', 'FontSize', 24);
text(0.1, 0.8, eq2_latex, 'Interpreter', 'latex', 'FontSize', 24);
title('Linearized System Equations in LaTeX', 'Interpreter', 'latex', 'FontSize', 16);
axis off;


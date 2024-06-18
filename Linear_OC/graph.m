ex = DrawP(@(x)P_rho(x, 2, 2), 100);
X = linspace(0, 1, 100);
hold on;
axis equal;
xlabel('$x_{1}$', 'Interpreter', 'latex','FontSize', 20, 'FontWeight', 'bold');
ylabel('$x_{2}$', 'Interpreter', 'latex', 'FontSize', 20, 'FontWeight', 'bold');
xlim([0 2]);
ylim([0 1.5]);
plot(ex(:, 1), ex(:, 2), 'b');
plot(X, X, '-r');
text(1, 0.4, ' $\leftarrow x_{1}^{2} + \sigma x_{2}^{2} = \zeta$', 'Interpreter', 'latex', 'FontSize', 20, 'FontWeight', 'bold');
text(1, 1.1, ' $\downarrow x_{1} = x_{2}$', 'Interpreter', 'latex', 'FontSize', 20, 'FontWeight', 'bold');
text(0.05, 1.1, ' $\downarrow \sigma x_{1}^{2} + x_{2}^{2} = \zeta$', 'Interpreter', 'latex', 'FontSize', 20, 'FontWeight', 'bold');
hold off;
function dydt = sistem(~, y, A, B, f, sigma, eta)
    dydt = zeros(4, 1);
    [~, u] = P_rho(transpose(B)* [y(3); y(4)], sigma, eta);
    dydt(1:2, 1) = A * [y(1); y(2)]+ B * u + f;
    dydt(3:4, 1) = -transpose(A) * [y(3); y(4)];
    % (x1, x2, psi1, psi2)
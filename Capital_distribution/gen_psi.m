function psi0 = gen_psi(N)
    phi = linspace(-pi, 0, N);
    teta = linspace(pi/2, pi, N);
    psi0(:, 1) = cos(teta);
    psi0(:, 2) = sin(teta).*cos(phi);
    psi0(:, 3) = sin(teta).*sin(phi);
 
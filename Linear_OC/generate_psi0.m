function psi0 = generate_psi0(N)
    X = linspace(pi, 2*pi , N); 
    psi0(:, 1) = cos(X);
    psi0(:, 2) = sin(X);
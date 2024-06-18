function point = opor_vec(rho, N)
    point = zeros(N, 2);
    %phi = linspace(0, 2* pi, N);
    %x = zeros(N, 2);
    for i = 1: N
        %x(i, :) = [cos(phi(i)), sin(phi(i))];
        [~, point(i, :)] = rho;
    end

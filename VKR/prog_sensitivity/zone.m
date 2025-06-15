function dydt = zone(t, y, r, w, beta, rho)
    dydt = [r .* y(1) + w - (y(2) ./ beta).^(1 / (beta - 1)); y(2) .* (rho - r)];
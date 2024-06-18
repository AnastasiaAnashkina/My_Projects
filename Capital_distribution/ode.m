function dydt = ode(t, y, mu, eps, del, gam, alp, r, bet, u1, u2, L, B, A, lam)
    dydt = zeros(4, 1);
    F = @(x) x.^lam .* L^(1 - lam); %на шаге итерации необходима проверка на > 0
    Fk = @(x) lam.*(L ./ x).^(1 - lam);
    dydt(1) = (1 - u1 - u2).* F(y(1)) - mu.* y(1);
    dydt(2) = (eps - del* u2).* F(y(1)) - gam.* y(2);
    dydt(3) = -alp.*A.* u1.*exp(-alp.*u1.*F(y(1))).*Fk(y(1)) + y(3).*(mu + r - ...
        (1 - u1 - u2).* Fk(y(1))) - y(4).*(eps - del.*u2).*Fk(y(1));
    dydt(4) = bet .* B.*exp(-bet.* y(2)) + y(4).*(gam + r);
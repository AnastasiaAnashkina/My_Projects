function vals = uAnalytical(xMat, yMat, u1zero, u2zero, mu)
    a = 1./(1 + mu);
    x_ch = @(x) (-6.*x.^2.*a.^2 + 48.*a.^4 - 24.*a.^3).*cos(x) + ...
        (-x.^3.*a - 6.*x.*a.^2 + 24.*x.*a.^3 - a).*sin(x);
    c2_x = (u1zero - x_ch(1) - (u1zero - 48.*a.^4 + 24.*a.^3).*exp(sqrt(mu)))./ ...
        (exp(-sqrt(mu)) - exp(sqrt(mu)));
    c1_x = u1zero - c2_x - 48.*a.^4 + 24.*a.^3;
    f1 = c1_x .* exp(sqrt(mu).*xMat) + c2_x .* exp(-sqrt(mu).*xMat) + x_ch(xMat);
    y_ch = @(x) (3./(4-mu).*x - 12./((4-mu).^2)) .* exp(2.*x) + a.*sin(x);
    c2_y = (u2zero - y_ch(1) - (u2zero + 12./((4 - mu).^2)).*exp(sqrt(mu)))./ ...
        (exp(-sqrt(mu)) - exp(sqrt(mu)));
    c1_y = u2zero - c2_y + 12./((4 - mu).^2);
    f2 = c1_y .* exp(sqrt(mu) .*yMat) + c2_y.*exp(-sqrt(mu).*yMat) + y_ch(yMat);
    vals = f1 - f2;
end
        
    
function vals = uNumerical(u1zero, u2zero, mu, M, N);
    fGiven = @(x, y) (1 + x.^3).*sin(x) - 3.*y.*exp(2.*y) - sin(y);
    xiHandle = @(x) uAnalytical(x, zeros(size(x)), u1zero, u2zero, mu);
    etaHandle = @(y) uAnalytical(zeros(size(y)), y, u1zero, u2zero, mu);
    vals = solveDirichlet(fGiven, xiHandle, etaHandle, mu, M, N);
end
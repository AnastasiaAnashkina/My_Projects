function root = safe_bisect(f, a, b, tol)
    max_iter = 100;
    fa = f(a); fb = f(b);
    if sign(fa) == sign(fb)
        error('Нет смены знака — метод бисекции не применим.');
    end

    for i = 1:max_iter
        c = (a + b)/2;
        fc = f(c);

        if ~isreal(fc)
            fc = real(fc);  % или выбрасывать ошибку
        end

        if abs(fc) < tol || abs(b - a) < tol
            root = c;
            return;
        end

        if sign(fc) == sign(fa)
            a = c;
        else
            b = c;
        end
    end
    root = (a + b)/2;
end
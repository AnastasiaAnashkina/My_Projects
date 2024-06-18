function [val, point] = X1_rho(l, a, b, c)
    %(a, b) - центр c - полудиагональ
    A = [a - c, b; a, b - c; a + c, b; a, b + c];
    l = l';
    [val, pos] = max(A * l);
    point = A(pos, :);

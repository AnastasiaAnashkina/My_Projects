function [value, isterminal, direction] = bord(t, y)
    value = y(1);          % следим за x(1) = 0
    isterminal = 1;        % остановка при событии
    direction = 0;         % любое пересечение (снизу или сверху)
end
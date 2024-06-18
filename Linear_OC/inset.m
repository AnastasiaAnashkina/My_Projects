function [position, isterminal, direction] = inset(t, x, a, b, c)
    position = abs(x(1) - a) + abs(x(2) - b) - c; %пересекаем X0
    isterminal = 1;
    direction = 0;
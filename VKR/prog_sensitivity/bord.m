function [value, isterminal, direction] = bord(t, y)
    value = y(1);          % ������ �� x(1) = 0
    isterminal = 1;        % ��������� ��� �������
    direction = 0;         % ����� ����������� (����� ��� ������)
end
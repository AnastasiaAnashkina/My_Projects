% ��������� ������
clear all;
rl = 3;      % ������ ��� ������
rd = 0.1;       % ������ ��� �������
beta = 0.6;
tol = 1e-4;
max_iter = 1000;
w = 3;
eps = 1e-4;
H = 30;
min_val = 0;
max_val = 500;
T = 500;
N = 10;
max_iters = 500;

t = linspace(0, T, max_iters);
k0 = transpose(gen_k(H, min_val, max_val));  % ��������� ��������
k = [];
grid1 = [];

%������� �����������
f = @(r, k, rho) (rho / r - beta)/(1 - beta)*(r * k + w);
g = @(r1, r2, k, rho, x)  -k / w - 1 / r1 + (1 - beta)/(rho - beta * r1)* x + x^(-r1 * (1- beta) / (rho - r1))* ((rho / r2 - beta) / (1 - beta))^(r1 * (1 - beta) / (rho - r1))* 1/r1 * (1 - (rho / r2 - beta)/(rho / r1 - beta));

% ��������� �����
start_point = @(rho, r) (rho / r - beta) / (1 - beta);

%�������� ����
for j = 1:max_iters - 1
    r_vec = zeros(H, 1);
    for z = 1: H
        if k0(z) <= 0
            r_vec(z) = rl;
        else
            r_vec(z) = rd;
        end
    end
    K_all = sum(k0.* r_vec + w);
    k = [k, zeros(H, N)];
    tspan = linspace(t(j), t(j+1), N);
    grid1 = [grid1, tspan];
    
    for i = 1:H
        x0 = k0(i);

        % ���������� ��������
        if x0 < 0
            r = rl;
        else
            r = rd;
        end

        rho = rho_culc(r, x0, w, K_all, H, beta);  % �������������� �������

        % ����� ������� �����������
        if x0 < 0.01 && rho > rl
            c = f(r, x0, rho);
        elseif x0 > 0.01 && rho > rl
            if r == rl
                r2 = rd;
            else
                r2 = rl;
            end
            h = @(x) g(r, r2, x0, rho, x);
            %c =w * fzero(h, [start_point(rho, r2), 10000]);
            c = w * safe_bisect(h, start_point(rho, r2), 10000, 1e-4);
        elseif x0 >= 0.01 && rho < rd
            c = f(r, x0, rho);
        elseif x0 < 0.01 && rho < rd
            if r == rl
                r2 = rd;
            else
                r2 = rl;
            end
            h = @(x) g(r, r2, x0, rho, x);
            %c = w * fzero(h,[0.001,max( start_point(rho, r2), 1e-4)]);
            c = w * safe_bisect(h, 0, start_point(rho, r2), 1e-4);
        elseif rho >=rd && rho <= rl && x0 < 0.01
            if r == rl
                r2 = rd;
            else
                r2 = rl;
            end
            h = @(x) g(r, r2, x0, rho, x);
            %c = w * fzero(h,[0.001,max( start_point(rho, r2), 1e-4)]);
            c = w * safe_bisect(h, 0, start_point(rho, r2), 1e-4);
        else
            if r == rl
                r2 = rd;
            else
                r2 = rl;
            end
            h = @(x) g(r, r2, x0, rho, x);
            %c =w * fzero(h, [start_point(rho, r2), 10000]);
            c = w * safe_bisect(h, start_point(rho, r2), 10000, 1e-4);
        end

        % ������� ���
        delta = 0.1;  % �����������
        [tt, y] = ode45(@(t, y) k_less(t, y, r, w, c), tspan, x0);
        x0 = y(end);
        k0(i) = x0;
        k(i, (j-1)*N + 1 : end) = transpose(y);
    end
end
% ������
figure('Name', '�������� �������� k(t)');
hold on;
grid on;
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 20);
ylabel('$k(t)$', 'Interpreter', 'latex', 'FontSize', 20);
set(gca, 'FontSize', 12);
plot(grid1, k, '-b', 'LineWidth', 1.2);
plot(grid1, -w/rl * ones(length(grid1)), '-r');

%������ ������� 
k_end = k(:, end)';
H = length(k_end);
k_sorted = sort(k_end);               % ��������� �� �����������
k_sorted(k_sorted < 0) = 0;             % ������������� ������� �������� (����� ��������)
r_vec = zeros(1, H);
for i = 1: H
    if k_sorted(i) >0
        r_vec(i) = rd;
    else
        r_vec(i) = rl;
    end
end
k_sorted = k_sorted .* r_vec + w;
cumulative_k = cumsum(k_sorted);        % ����������� ��������
total_k = sum(k_sorted);                % ����� �������
%r_vec = zeros(H);
if total_k == 0
    L_end = zeros(size(cumulative_k));
else
    L_end = cumulative_k / total_k;         % ���� ������������ ��������
end
x = linspace(0, 1, H);                  % ���� �������
x = [0, x];
L_end = [0, L_end];

%������ ������� � ��������� ������
k_start = k(:, 1)';
%H = length(k_start);
k_sorted = sort(k_start);               % ��������� �� �����������
k_sorted(k_sorted < 0) = 0;             % ������������� ������� �������� (����� ��������)
r_vec = zeros(1, H);
for i = 1: H
    if k_sorted(i) >0
        r_vec(i) = rd;
    else
        r_vec(i) = rl;
    end
end
k_sorted = k_sorted .* r_vec + w;
cumulative_k = cumsum(k_sorted);        % ����������� ��������
total_k = sum(k_sorted);                % ����� �������
%r_vec = zeros(H);
if total_k == 0
    L_start = zeros(size(cumulative_k));
else
    L_start = cumulative_k / total_k;         % ���� ������������ ��������
end
L_start = [0, L_start];
%������ ������� � ��������
k_mid = k(:, ceil(length(k) / 2))';
%H = length(k_start);
k_sorted = sort(k_mid);               % ��������� �� �����������
k_sorted(k_sorted < 0) = 0;             % ������������� ������� �������� (����� ��������)
r_vec = zeros(1, H);
for i = 1: H
    if k_sorted(i) >0
        r_vec(i) = rd;
    else
        r_vec(i) = rl;
    end
end
k_sorted = k_sorted .* r_vec + w;
cumulative_k = cumsum(k_sorted);        % ����������� ��������
total_k = sum(k_sorted);                % ����� �������
%r_vec = zeros(H);
if total_k == 0
    L_mid = zeros(size(cumulative_k));
else
    L_mid = cumulative_k / total_k;         % ���� ������������ ��������
end
L_mid = [0, L_mid];

% ������ ������� �� ����� ������� �� �����
k_third = k(:, end - ceil(length(k) / 3))';
%H = length(k_start);
k_sorted = sort(k_third);               % ��������� �� �����������
k_sorted(k_sorted < 0) = 0;             % ������������� ������� �������� (����� ��������)
r_vec = zeros(1, H);
for i = 1: H
    if k_sorted(i) >0
        r_vec(i) = rd;
    else
        r_vec(i) = rl;
    end
end
k_sorted = k_sorted .* r_vec + w;
cumulative_k = cumsum(k_sorted);        % ����������� ��������
total_k = sum(k_sorted);                % ����� �������
%r_vec = zeros(H);
if total_k == 0
    L_third = zeros(size(cumulative_k));
else
    L_third = cumulative_k / total_k;         % ���� ������������ ��������
end
L_third = [0, L_third];

    % ���������� �������
figure('Name', '������ �������');


plot(x, L_start, 'r-', 'LineWidth', 2);
hold on;
plot(x, L_mid, 'g-', 'LineWidth', 2);
plot(x, L_third, 'm-', 'LineWidth', 2);
plot(x, L_end, 'b-', 'LineWidth', 2);
plot([0 1], [0 1], 'k--', 'LineWidth', 1.5);  % ����� ���������
grid on;
xlabel('���� ������������');
ylabel('���� ��������');
%title('������ �������');
set(gca, 'FontSize', 12);
lgd = legend('����������� ������������� � ��������� ������ �������','����������� ������������� � ��������� ������ �������', ...
    '����������� ������������� � �������� ���������� �������','����������� ������������� � �������� ������ ������� �������',...
    '����������� ���������', 'Location', 'NorthWest');
lgd.FontSize = 14;

% figure('Name', '������ �������');
% plot(x, L_end, 'b-', 'LineWidth', 2);
% hold on;
% plot([0 1], [0 1], 'k--', 'LineWidth', 1.5);  % ����� ���������
% grid on;
% xlabel('���� ������������');
% ylabel('���� ��������');
% %title('������ �������');

%������ �����
gini_index = zeros(1, size(k, 2)); % ������������� ������� ��� �������� ������� �����

for time_idx = 1:size(k, 2)
    current_k = k(:, time_idx)';
    k_sorted = sort(current_k);               % ��������� �� �����������
    k_sorted(k_sorted < 0) = 0;               % ������������� ������� ��������
    
    % ���������� ������ ��� ������� ������
    r_vec = zeros(1, H);
    for i = 1:H
        if k_sorted(i) > 0
            r_vec(i) = rd;
        else
            r_vec(i) = rl;
        end
    end
    
    k_sorted = k_sorted .* r_vec + w;         % ��������� ����� �� �������� � ��������
    cumulative_k = cumsum(k_sorted);          % ����������� ��������
    total_k = sum(k_sorted);                  % ����� �������
    
    if total_k == 0
        L = zeros(size(cumulative_k));
    else
        L = cumulative_k / total_k;           % ������ �������
    end
    
    % ��������� ��������� ����� (0,0)
    x = linspace(0, 1, H);
    x = [0, x];
    L = [0, L];
    
    % ��������� ������� ��� ������ ������� (������� ��������)
    area_under_L = trapz(x, L);
    
    % ������ ����� = (0.5 - area_under_L) / 0.5 = 1 - 2*area_under_L
    gini_index(time_idx) = 1 - 2 * area_under_L;
end

% ���������� ������� �������� ������� �����
figure('Name', '�������� ������� �����');
plot(grid1, gini_index, '-b', 'LineWidth', 2);
grid on;
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 20);
ylabel('������ �����', 'FontSize', 12);
%title('�������� ������� ����� �� �������', 'FontSize', 14);
set(gca, 'FontSize', 12);

% ����� ���������� � ��������� �������� ������� �����
fprintf('��������� ������ �����: %.4f\n', gini_index(1));
fprintf('�������� ������ �����: %.4f\n', gini_index(end));

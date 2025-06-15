% main3_multiple_rl.m
% ������������� � ���������� ������ ������� ��� ���������� �������� rl

clear all; close all;

% ������� ��������� �������� rl
rl_values = [1.2];

% ����� ��������� ������
rd = 0.1;
beta = 0.8;
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

% ��������� ����� ��� ����������
t = linspace(0, T, max_iters);

%������� �����������
f = @(r, k, rho) (rho / r - beta)/(1 - beta)*(r * k + w);
g = @(r1, r2, k, rho, x)  -k / w - 1 / r1 + (1 - beta)/(rho - beta * r1)* x + x^(-r1 * (1- beta) / (rho - r1))* ((rho / r2 - beta) / (1 - beta))^(r1 * (1 - beta) / (rho - r1))* 1/r1 * (1 - (rho / r2 - beta)/(rho / r1 - beta));

% ��������� �����
start_point = @(rho, r) (rho / r - beta) / (1 - beta);


% ������ ���������� ������������� ��������
k0_template = gen_k(H, min_val, max_val)';

% ���������� �������
figure('Name', '������ ������� ��� ������ rl');
hold on; grid on;
xlabel('���� ������������');
ylabel('���� ��������');
set(gca, 'FontSize', 12);
colors = lines(length(rl_values));

for idx = 1:length(rl_values)
    rl = rl_values(idx);
    k0 = k0_template;
    % ��������������� ��������� ������
    k = zeros(H, (max_iters - 1)*N);
    grid1 = zeros(1, (max_iters - 1)*N);

    % �������� ���� �������������
    for j = 1:(max_iters - 1)
        % ����������� ������ ��� ������� ������
        r_vec = rd * ones(H,1);
        r_vec(k0 <= 0) = rl;
        K_all = sum(k0 .* r_vec + w);

        % ��������� �������
        tspan = linspace(t(j), t(j+1), N);
        startIdx = (j-1)*N + 1;
        endIdx   = j*N;
        grid1(startIdx:endIdx) = tspan;

        for i = 1:H
            x0 = k0(i);
            r = rd; if x0 <= 0, r = rl; end
            rho = rho_culc(r, x0, w, K_all, H, beta);

            % ����� ������� �����������
            if x0 < 0.01 && rho > rl
                c = f(r, x0, rho);
            elseif x0 > 0.01 && rho > rl
                r2 = (r == rl) * rd + (r == rd) * rl;
                h = @(x) g(r, r2, x0, rho, x);
                c = w * safe_bisect(h, start_point(rho, r2), 10000, tol);
            elseif x0 >= 0.01 && rho < rd
                c = f(r, x0, rho);
            else
                r2 = (r == rl) * rd + (r == rd) * rl;
                h = @(x) g(r, r2, x0, rho, x);
                c = w * safe_bisect(h, 0, start_point(rho, r2), tol);
            end

            % �������������� ���
            [~, y] = ode45(@(tt, yy) k_less(tt, yy, r, w, c), tspan, x0);
            k0(i) = y(end);
            k(i, (j-1)*N + 1 : end) = y';
        end
    end

    % ������ ������ ������� � �������� ������
    k_end = k(:, end)';
    k_end(k_end < 0) = 0;
    k_sorted = sort(k_end);
    r_vec = rd * ones(1, H);
    r_vec(k_sorted <= 0) = rl;
    k_vals = k_sorted .* r_vec + w;
    cumulative_k = cumsum(k_vals);
    total_k = sum(k_vals);
    if total_k == 0
        L_end = zeros(1, H);
    else
        L_end = cumulative_k / total_k;
    end
    x = [0, linspace(0, 1, H)];
    L_end = [0, L_end];

    % ���������� ������ ��� ������� rl
    plot(x, L_end, 'LineWidth', 2, 'Color', colors(idx, :));
end

% ����� ��������� � �������
plot([0 1], [0 1], 'k--', 'LineWidth', 1.5);
legend(arrayfun(@(v) sprintf('rl = %g', v), rl_values, 'UniformOutput', false), 'Location', 'NorthWest');
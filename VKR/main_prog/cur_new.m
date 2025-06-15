clc;
rl_vec = [2, 20, 1000];      % ставка для бедных
rd = 0.1;      % ставка для богатых
beta = 0.3;
tol = 1e-4;
max_iter = 1000;
w = 2;
eps = 1e-4;
H = 30;
min_val = 0;
max_val = 500;
T = 1000;
N = 50;
max_iters = 1000;
t = linspace(0, T, max_iters);
k0 = transpose(gen_k(H, min_val, max_val));  % генерация капитала

%функуии потребления
f = @(r, k, rho) (rho / r - beta)/(1 - beta)*(r * k + w);
g = @(r1, r2, k, rho, x)  -k / w - 1 / r1 + (1 - beta)/(rho - beta * r1)* x + x^(-r1 * (1- beta) / (rho - r1))* ((rho / r2 - beta) / (1 - beta))^(r1 * (1 - beta) / (rho - r1))* 1/r1 * (1 - (rho / r2 - beta)/(rho / r1 - beta));

% начальные точки
start_point = @(rho, r) (rho / r - beta) / (1 - beta);

%начало построения графика
figure('Name', 'Чувствительность к параметру');
hold on;
grid on;
xlabel('Доля домохозяйств', 'FontSize', 16);
ylabel('Доля капитала', 'FontSize', 16);
colors = lines(length(rl_vec));

for s = 1:length(rl_vec)
%     k0 = transpose(gen_k(H, min_val, max_val));  % генерация капитала
    k = [];
    grid1 = [];
    rl = rl_vec(s);
    k_cur = k0;
    for j = 1:max_iters - 1
        r_vec = zeros(H, 1);
        for z = 1: H
            if k_cur(z) <= 0
                r_vec(z) = rl;
            else
                r_vec(z) = rd;
            end
        end
        K_all = sum(k_cur.* r_vec + w);
        k = [k, zeros(H, N)];
        tspan = linspace(t(j), t(j+1), N);
        grid1 = [grid1, tspan];
        
        for i = 1:H
            x0 = k_cur(i);

        % Переходный механизм
            if x0 < 0
                r = rl;
            else
                r = rd;
            end

            rho = rho_culc(r, x0, w, K_all, H, beta);  % адаптированная формула

        % Выбор функции потребления
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

        % Решение ОДУ
            delta = 0.1;  % амортизация
            [tt, y] = ode45(@(t, y) k_less(t, y, r, w, c), tspan, x0);
            x0 = y(end);
            k_cur(i) = x0;
            k(i, (j-1)*N + 1 : end) = transpose(y);
        end
    end
    %Кривая Лоренца 
    k_end = k(:, end)';
    H = length(k_end);
    k_sorted = sort(k_end);               % Сортируем по возрастанию
    k_sorted(k_sorted < 0) = 0;             % Отрицательные считаем нулевыми (можно обсудить)
    r_vec = zeros(1, H);
    for i = 1: H
        if k_sorted(i) >0
            r_vec(i) = rd;
        else
            r_vec(i) = rl;
        end
    end
    k_sorted = k_sorted .* r_vec + w;
    cumulative_k = cumsum(k_sorted);        % Накопленные капиталы
    total_k = sum(k_sorted);                % Общий капитал
    %r_vec = zeros(H);
    if total_k == 0
        L_end = zeros(size(cumulative_k));
    else
        L_end = cumulative_k / total_k;         % Доля накопленного капитала
    end
    x = linspace(0, 1, H);                  % Доля агентов
    x = [0, x];
    L_end = [0, L_end];
    plot(x, L_end, 'LineWidth', 2,'Color', colors(s, :));
    disp(s);
end
lgd = legend(arrayfun(@(v) sprintf('rl = %g', v), rl_vec, 'UniformOutput', false), 'Location', 'NorthWest');
lgd.FontSize = 14;
hold off;

    

clc;
%параметры
rho = 5;
rl = 9;      % ставка для бедных
rd = 1;       % ставка для богатых
beta = 0.5;
max_iter = 1000;
w = 1;
k0 = 10;
N = 1000;
T = 200;
t = linspace(0, T, N);

%функуии потребления
f = @(r, k, rh) (rh / r - beta)/(1 - beta)*(r * k + w);
g = @(r1, r2, k, rh, x)  -k / w - 1 / r1 + (1 - beta)/(rh - beta * r1)* x + x^(-r1 * (1- beta) / (rh - r1))* ((rh / r2 - beta) / (1 - beta))^(r1 * (1 - beta) / (rh - r1))* 1/r1 * (1 - (rh / r2 - beta)/(rh / r1 - beta));

% начальные точки для поиска корней
start_point = @(rh, r) (rh / r - beta) / (1 - beta);

% if rho > rl && k0 <= 0
%    c = f(rl, k0, rho); 
% elseif rho > rl && k0 > 0
%     h = @(x) g(r, r2, x0, rho, x);
%     c = w * safe_bisect(h, start_point(rho, rl), 10000, 1e-4);
% end

 % Переходный механизм
if k0 < 0
    r = rl;
else
    r = rd;
end
 % Выбор функции потребления
if k0 < 0.01 && rho > rl
    c = f(r, k0, rho);
elseif k0 > 0.01 && rho > rl
    if r == rl
        r2 = rd;
    else
        r2 = rl;
    end
    h = @(x) g(r, r2, k0, rho, x);
    c = w * safe_bisect(h, start_point(rho, r2), 10000, 1e-4);
elseif k0 >= 0.01 && rho < rd
    c = f(r, k0, rho);
elseif k0 < 0.01 && rho < rd
    if r == rl
        r2 = rd;
    else
        r2 = rl;
    end
    h = @(x) g(r, r2, k0, rho, x);
    c = w * safe_bisect(h, 0, start_point(rho, r2), 1e-4);
elseif rho >=rd && rho <= rl && k0 < 0.01
    if r == rl
        r2 = rd;
    else
        r2 = rl;
    end
    h = @(x) g(r, r2, k0, rho, x);
    c = w * safe_bisect(h, 0, start_point(rho, r2), 1e-4);
else
    if r == rl
        r2 = rd;
    else
        r2 = rl;
    end
    h = @(x) g(r, r2, k0, rho, x);
    c = w * safe_bisect(h, start_point(rho, r2), 10000, 1e-4);
end

psi0 = beta * c^(beta - 1);
x = [k0; psi0];
disp(x);
opts = odeset('Events', @bord);
zero_cross_count = 0;
for i = 1 : N - 1
    y0 = [k0, psi0];
    tspan = [t(i) t(i + 1)];
    if k0 <= 0    
        [tt, y, te, xe, ie] = ode45(@(t, y)zone(t, y, rl, w, beta, rho), tspan, y0, opts);
    else
        [tt, y, te, xe, ie] = ode45(@(t, y)zone(t, y, rd, w, beta, rho), tspan, y0, opts);
    end
    
    if ~isempty(te)
        zero_cross_count = zero_cross_count + 1;
        if rho >= rd && rho <= rl
            x = [x, transpose(y)];
            disp('первое пересечение во втором случае пересечение x(1) = 0. Останов.');
            break;
        end
        if zero_cross_count == 2
            % Добавляем последнее значение
            x = [x, transpose(y)];
            disp('Второе пересечение x(1) = 0. Останов.');
            break;
        end
    end
%    figure('Name', 'PLi');
%     hold on;
%     plot(t, y);
%     hold off;
    k0 = y(end, 1);
    psi0 = y(end, 2);
%     x(:, i + 1) = [x_0; phi_0];
   % disp(i);
    x = [x, transpose(y)];
end

%график
figure('Name', 'PL');
hold on;
grid on;
xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\psi$', 'Interpreter', 'latex', 'FontSize', 16);
gridd = linspace(max(min(x(1, :)), 0), max(x(1, :)), length(x));
grid_R = linspace(-w / rl, max(x(1, :)), length(x'));
psi_z = zeros(size(grid_R));
psi_z(grid_R <= 0) = beta ./ (rl * grid_R(grid_R < 0) + w).^(1 - beta);
psi_z(grid_R > 0)  = beta ./ (rd * grid_R(grid_R >= 0)  + w).^(1 - beta);
% psi_z = [psi_z, beta / w^(1 - beta)];
% grid_R = [grid_R, 0];
% psi_z = sort(psi_z, 'descend');
% grid_R = sort(grid_R, 'descend');
%psi_z(psi_z == Inf) = beta / w^(1 - beta);
h1 = plot(grid_R, psi_z, '-r');
ylim([0, 1]);
%xlim([-0.6, 0.1]);
hights = 4;
h3 = plot(x(1, :), x(2, :), '-m', 'LineWidth', 2);
h4 = plot(-w/rl * ones(1, length(x')), linspace(0, hights, length(x')), '-b');
plot(0, beta / w^(1 - beta), 'ob')
plot(zeros(1, length(x')),linspace(0, hights, length(x')), '-k');
lgd = legend([h3, h1], {'Оптимальная траектория', 'Кривая разворота'});
lgd.FontSize = 14;
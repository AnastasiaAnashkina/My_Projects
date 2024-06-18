function [X, u_opt, T, x_opt, tvec_opt, err, N_up, psi0, L] = decition(N,N_up,psi0, t0, time, sig, eta, a, b, c, x0, A, B, f, upgrade)
    s = 0;
    eps = 1e-5; %для проверки на невырожденность
    opts = odeset('Events', @(t, x)inset(t, x, a, b, c));
    if upgrade == 1
        psi0_up = zeros(N_up, 2);
        for i = 1: size(psi0, 1) - 1
            psi0_up(i, :) = (psi0(i, :) + psi0(i + 1, :))./2;
        end
    %i = 1;
        psi0_tmp = zeros(2*N_up, 2);
        for i = 1: size(psi0, 1)
            psi0_tmp(i, :)= psi0(i, :);
            psi0_tmp(i + 1, :) = psi0_up(i, :);
        end
        psi0 = psi0_tmp;  
        disp(size(psi0, 1));
    %psi0 = [psi0; psi0_up]; % если больше одного улучшения надо сохранять
        for i = 1: N_up
            psi_0_up = psi0_up(i, :);
            [~, x_0_up] = X0_rho(psi_0_up, x0);
            tspan = [t0, time];
            [t, y, te, ye, ie] = ode45(@(t, y)sistem(t, y, A, B, f, sig, eta), tspan, [x_0_up, psi_0_up], opts);
            if size(y, 1) == 1 
                disp('множества пересекаются');
                break;
            elseif isempty(ie) %не дошли до X1
                inX1 = 0;
                % disp('pip');
                s = s+1;
            else 
                psi = transpose([y(:, 3), y(:, 4)]); %строка
                x = [y(:, 1), y(:, 2)];% столбец
                [~, u] = P_rho(transpose(A)*psi, sig, eta);%строка
                u = transpose(u); % строка
                %disp(t);
                L = [L, size(t, 1)] ;
                X = [X; x];
                %disp(i);
                T = [T; t];
                if te < t_opt
                    t_opt = te;
                    tvek_opt = t;
                    u_opt = u;
                    x_opt = x; % на какой итерации достигается
                    [val_pred, x_pred] = X1_rho(transpose(-psi(:,size(t, 1))), a, b, c);
                    scal = -x(size(t, 1), :)*psi(:, size(t, 1));
                    err = abs(scal - val_pred);
                    %err = norm(x(end) - x_pred);
                    % disp(err);
                end
            end
        end
        N_up = N_up * 2;
    else
        psi0 = generate_psi0(N); % в else
        X = []; % для построение всех траекторий
        T = []; % для отрисовки всех траекторий
        L = []; % число координат при каждой итерации, чтобы потом отличать их от всей матрицы
        t_opt = time;
        err = 0;
        N_up = N;
        for i = 1: N %заменить на N
            inX1 = 1;
            psi_0 = psi0(i,:);
            %[t, psi] = psi_decition(A, psi_0, t0, time);
            %u_opt = opor_vec(P_rho(psi))
            %[~, u_opt] = P_rho(psi, sig, eta);
            %u_opt = transpose(u_opt) % строка
            [~, x_0] = X0_rho(psi_0, x0);
            tspan = [t0, time];
            % необходимо добиться невырожденности матрицы B
            [U, S, V] = svd(B);
            S(find(abs(S)) < eps) = 1e-2;
            B = U*S*transpose(V);
            [t, y, te, ye, ie] = ode45(@(t, y)sistem(t, y, A, B, f, sig, eta), tspan, [x_0, psi_0], opts);
            if size(y, 1) == 1 
                disp('множества пересекаются');
                break;
            elseif isempty(ie) %не дошли до X1
                inX1 = 0;
                % disp('pip');
                s = s+1;
            else 
                psi = transpose([y(:, 3), y(:, 4)]); %строка
                x = [y(:, 1), y(:, 2)];% столбец
                [~, u] = P_rho(transpose(A)*psi, sig, eta);%строка
                u = transpose(u); % строка
                %disp(t);
                L = [L, size(t, 1)] ;
                X = [X; x];
                %disp(i);
                T = [T; t];
                if te < t_opt
                    tvec_opt = t;
                    t_opt = te;
                    u_opt = u;
                    x_opt = x; % на какой итерации достигается
                    [val_pred, ~] = X1_rho(transpose(-psi(:,size(t, 1))), a, b, c);
                    scal = -x(size(t, 1), :)*psi(:, size(t, 1));
                    err = abs(scal - val_pred);
                    %err = norm(x(end) - x_pred);
                    % disp(err);
                end
            end
        end
    end
    %disp('The error: ', num2str(err));
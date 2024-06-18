function Shift(pos, var)% расстановка чисел в таблицу
    %При изменениии одной позиции меняется талбица
    esc = evalin("base", 'esc');
    Maze = evalin("base", 'Maze');
    obs = Maze.field;
    global r;
    n = size(obs, 1);
   % n = n(1);
    m = size(obs, 2);
    i = pos(1); %на вход поступает точка 
    j = pos(2);
    flag = false; % true если таблица поменялась
    if (j + 1) <= m && ~isinf(esc(i, j)) && (esc(i, j + 1) ~= r) %сдвиг влево
        if esc(i, j + 1) + 1 < esc(i, j)
            esc(i, j) = esc(i, j + 1) + 1;
            flag = true;
        end
    end
    if (i + 1) <= n && ~isinf(esc(i, j)) && (esc(i + 1, j) ~= r)%сдвиг вниз
        if esc(i + 1, j) + 1 < esc(i, j)
            esc(i, j) = esc(i + 1, j) + 1;
            flag = true;
        end
    end
    if (j - 1) >= 1 && ~isinf(esc(i, j)) && (esc(i, j - 1) ~= r)% сдвиг вправо
        if esc(i, j - 1) + 1 < esc(i, j)
            esc(i, j) = esc(i, j - 1) + 1;
            flag = true;
        end
    end
    if (i - 1) >= 1 && ~isinf(esc(i, j)) && (esc(i - 1, j) ~= r)% сдвиг вверх
        if esc(i - 1, j) + 1 < esc(i, j)
            esc(i, j) = esc(i - 1, j) + 1;
            flag = true;
        end
    end
    if var
        if i-1 >= 1 && j+1 <= m && ~isinf(esc(i, j)) && (esc(i-1, j+1) ~= r) % влево вверх
            if esc(i-1, j+1) + 1 < esc(i, j)
                esc(i, j) = esc(i-1, j+1) + 1;
                flag = true;
            end
        end
        if i-1 >=1 && j-1 >= 1 && ~isinf(esc(i, j)) && (esc(i-1, j-1) ~= r)%вправо вверх
            if esc(i-1, j-1) + 1 < esc(i, j)
                esc(i, j) = esc(i-1, j-1) + 1;
                flag = true;
            end
        end
        if i+1 <= n && j-1 >= 1 && ~isinf(esc(i, j)) && (esc(i+1, j-1) ~= r)%вправо вниз
            if esc(i+1, j-1) + 1 < esc(i, j)
                esc(i, j) = esc(i+1, j-1) + 1;
                flag = true;
            end
        end
        if i+1 <= n && j+1 <= m && ~isinf(esc(i, j)) && (esc(i+1, j+1) ~= r)%вправо вверх
            if esc(i+1, j+1) + 1 < esc(i, j)
                esc(i, j) = esc(i+1, j+1) + 1;
                flag = true;
            end
        end
    end
    if flag %запускаем рекурсию
        %disp('pup');
        %disp(esc);
        assignin("base", 'esc', esc);
        if j - 1 >= 1 %сдвиг влево
            Shift([i j-1], var);
        end
        if j + 1 <= m %сдвиг вправо
            Shift([i j+1], var);
        end
        if i - 1 >= 1 %сдвиг вниз
            Shift([i-1 j], var);
        end
        if i + 1 <= n %сдвиг вверх
            Shift([i+1 j], var);
        end
        if var
            if i-1 >= 1 && j-1 >= 1
                Shift([i-1 j-1], var);
            end
            if i-1 >= 1 && j+1 <= m
                Shift([i-1 j+1], var);
            end
            if i+1 <= n && j-1 >= 1
                Shift([i+1 j-1], var);
            end
            if i+1 <=n && j+1 <= m
                Shift([i+1 j+1], var);
            end
        end
    end
end

    
        
    
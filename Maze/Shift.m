function Shift(pos, var)% ����������� ����� � �������
    %��� ���������� ����� ������� �������� �������
    esc = evalin("base", 'esc');
    Maze = evalin("base", 'Maze');
    obs = Maze.field;
    global r;
    n = size(obs, 1);
   % n = n(1);
    m = size(obs, 2);
    i = pos(1); %�� ���� ��������� ����� 
    j = pos(2);
    flag = false; % true ���� ������� ����������
    if (j + 1) <= m && ~isinf(esc(i, j)) && (esc(i, j + 1) ~= r) %����� �����
        if esc(i, j + 1) + 1 < esc(i, j)
            esc(i, j) = esc(i, j + 1) + 1;
            flag = true;
        end
    end
    if (i + 1) <= n && ~isinf(esc(i, j)) && (esc(i + 1, j) ~= r)%����� ����
        if esc(i + 1, j) + 1 < esc(i, j)
            esc(i, j) = esc(i + 1, j) + 1;
            flag = true;
        end
    end
    if (j - 1) >= 1 && ~isinf(esc(i, j)) && (esc(i, j - 1) ~= r)% ����� ������
        if esc(i, j - 1) + 1 < esc(i, j)
            esc(i, j) = esc(i, j - 1) + 1;
            flag = true;
        end
    end
    if (i - 1) >= 1 && ~isinf(esc(i, j)) && (esc(i - 1, j) ~= r)% ����� �����
        if esc(i - 1, j) + 1 < esc(i, j)
            esc(i, j) = esc(i - 1, j) + 1;
            flag = true;
        end
    end
    if var
        if i-1 >= 1 && j+1 <= m && ~isinf(esc(i, j)) && (esc(i-1, j+1) ~= r) % ����� �����
            if esc(i-1, j+1) + 1 < esc(i, j)
                esc(i, j) = esc(i-1, j+1) + 1;
                flag = true;
            end
        end
        if i-1 >=1 && j-1 >= 1 && ~isinf(esc(i, j)) && (esc(i-1, j-1) ~= r)%������ �����
            if esc(i-1, j-1) + 1 < esc(i, j)
                esc(i, j) = esc(i-1, j-1) + 1;
                flag = true;
            end
        end
        if i+1 <= n && j-1 >= 1 && ~isinf(esc(i, j)) && (esc(i+1, j-1) ~= r)%������ ����
            if esc(i+1, j-1) + 1 < esc(i, j)
                esc(i, j) = esc(i+1, j-1) + 1;
                flag = true;
            end
        end
        if i+1 <= n && j+1 <= m && ~isinf(esc(i, j)) && (esc(i+1, j+1) ~= r)%������ �����
            if esc(i+1, j+1) + 1 < esc(i, j)
                esc(i, j) = esc(i+1, j+1) + 1;
                flag = true;
            end
        end
    end
    if flag %��������� ��������
        %disp('pup');
        %disp(esc);
        assignin("base", 'esc', esc);
        if j - 1 >= 1 %����� �����
            Shift([i j-1], var);
        end
        if j + 1 <= m %����� ������
            Shift([i j+1], var);
        end
        if i - 1 >= 1 %����� ����
            Shift([i-1 j], var);
        end
        if i + 1 <= n %����� �����
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

    
        
    
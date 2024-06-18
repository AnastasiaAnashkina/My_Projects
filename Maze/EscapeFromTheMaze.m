function EscapeFromTheMaze(var)
    Maze = evalin("base", 'Maze'); % таблица с преп€тстви€ми
    obs = Maze.field;
    global r; 
    r = 100;
    n = size(obs, 1); % столбцы
    m = size(obs, 2); %строки
    esc = r * ones(n, m); % чтобы эти позиции не были минимальными
    %[row, col] = find(obs); % нашли на каких позици€х преп€тстви€
    %esc(row, col) = Inf % где преп€тствие Inf, чтобы знать где они
    for i = 1: n
        for j = 1: m
            if obs(i, j) == 1
                esc(i, j) = Inf;
            end
        end
    end    
    esc(1, m) = 0;
    assignin("base", 'esc', esc);
    if m-1 >= 1 && ~isinf(esc(n, m-1)) 
        Shift([1 m-1], var);
    end
    if n-1 >= 1 && ~isinf(esc(n-1, m))
        Shift([2 m], var);
    end
    if var
        if n-1 >= 1 && m-1 >= 1
            Shift([2 m-1], var);
        end
    end
    esc = evalin( "base", 'esc');
    %dir = strings(1, esc(n, 1)) % создали вектор строк длины как врем€
    dir = [];
    assignin("base", 'dir', dir);
    Path([n 1], var);
    disp(esc(n,1));
    if (esc(n, 1) == r) 
        disp('NO ESCAPE!!!!');
        return;
    end
    dir = evalin("base", 'dir');
%     axis([0 n 0 m]);
%     grid on;
%     hold on;
   % f = evalin("base", 'figure'); 
    figure(2);
    axis([0 m 0 n]);
    grid on;
    hold on;
   % h = evalin("base", 'fill');
   % obs = flipud(obs');
    obs = flipud(obs);
    obs = obs';
    for i = 1: m
        for j = 1: n
            if obs(i, j) == 1
                %fill([i - 1, i - 1, i, i], [j - 1, j, j, j - 1], [0.5 0 0.5]);
                fill( [i - 1, i, i, i - 1], [j - 1, j - 1, j, j], [0.5 0 0.5])
            end
        end
    end
    x1(1) = 1 - 0.5;
    x1(2) = 1 - 0.5;
    plot(x1(1), x1(2),'*r');
    %x2 = zeros(1, 2);
    length(dir)
    for i = 1: length(dir)
        if dir(i) == '1' % вправо вверх
            quiver(x1(1),x1(2), 1, 1, 0);
            x1 = [x1(1) + 1, x1(2) + 1];
        elseif dir(i) == 'r'% вверх
            quiver(x1(1), x1(2), 1, 0, 0);
            x1 = [x1(1)+1, x1(2)];
        elseif dir(i) == 'u' %вправо
            quiver(x1(1), x1(2), 0, 1, 0);
            x1 = [x1(1), x1(2) + 1];
        elseif dir(i) == '3' % вправо вниз
            quiver(x1(1), x1(2), -1, 1, 0);
            x1 = [x1(1) - 1, x1(2) + 1];
        elseif dir(i) == 'l'% вниз
            quiver(x1(1), x1(2), -1, 0, 0);
            x1 = [x1(1) - 1, x1(2)];
        elseif dir(i) == '2' %вверх влево
            quiver(x1(1), x1(2), 1, -1, 0);
            x1 = [x1(1)+1, x1(2) - 1];
        elseif dir(i) == 'd' %лево
            quiver(x1(1), x1(2), 0, -1, 0);
            x1 = [x1(1), x1(2)-1];
        elseif dir(i) == '4' % вниз влево
            quiver(x1(1), x1(2), -1, -1, 0);
            x1 = [x1(1) - 1, x1(2) - 1];
        end
    end
    esc = flipud(esc);
    esc = esc';
    for i = 1: m
        for j = 1:n 
            text(i - 0.5, j-0.5, num2str(esc(i, j)));
        end
    end
    title('Plan of evacuation', 'Interpreter', 'latex');
    hold off;
            
            
    
        
     
    
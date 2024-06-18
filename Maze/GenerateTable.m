function GenerateTable(n, m)
    field = zeros(n, m);
    n_obs = randi([1, 3]);% количество преп€тствий
    minsize = 2;%ћинимальный размер преп€тствий
    maxsize = min(n/2, m/2);
    f = figure('Name', 'Evacuation');
    axis([0 n 0 m]);
    grid on;
    hold on;
    title('Evacuation', 'Interpreter', 'latex');
    for i = 1: n_obs %увеличение по x только вправо по y только вверх
        size_x = randi([minsize, maxsize]);
        size_y = randi([minsize, maxsize]);
        start_x = randi([1, n - size_x + 1]);
        start_y = randi([1, m - size_y + 1]);
        if (start_x == 1) && (start_y == 1) %(0, 0) мб только началом преп€тстви€
            start_x = start_x + 1;
            size_x = size_x - 1;
        end
        if ((start_x + size_x - 1) == n) && ((start_y + size_y - 1) == m) %(n, m) мб только концом  
            size_x = size_x - 1;
            %size_y = size_y - 1;
        end
        for j = start_x : (start_x + size_x - 1)
            for k = start_y : (start_y + size_y - 1)
%                 disp([num2str(j), ',', num2str(k)]); 
                field(j, k) = 1;
                h(i) = fill([j - 1, j - 1, j, j], [k - 1, k, k, k - 1], [0.5 0 0.5]);
            end
        end
    end
    if (field(1, 1) == 1) 
        field(1, 1) = 0;
    end
    if (field(n, m) == 1)
        field(n, m) = 0;
    end
    field = flipud(field');
    Maze = struct('field', field, 'figure', f, 'fill', h);
    Maze.field;
    assignin("base", 'Maze', Maze);

%     pcolor(field);
%     colormap summer;
%     c = heatmap(field); 
%     c.YData = flipud(c.YData);
%     field = flipud(field);
%     c.ColorbarVisible = 'off';
%     f = figure('Name', 'Evacuation');
%     axis([0 n 0 m]);
%     grid on;
%     hold on;]
%     title('Evacuation', 'Interpreter', 'latex');
%     for i = 1: n_obs % размеры и позиции преп€тствий 
%         size_x = randi([minsize, maxsize]);
%         size_y = randi([minsize, maxsize]);
%         start_x = randi([1, n - size_x + 1]);
%         start_y = randi([1, m - size_y + 1]);
     
    
    
    
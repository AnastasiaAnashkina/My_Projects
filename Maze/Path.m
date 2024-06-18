function Path(x,var)
    esc = evalin("base", 'esc');
    dir = evalin("base", 'dir');
    n = size(esc, 1);
    m = size(esc, 2);
    i = x(1);
    j = x(2);
    %dir = [];
    p = []; % отличие на 1
    if var % сначала проверяем по - диагонали
        if i-1 >= 1 && j+1 <= m % вправо - вверх 
            if esc(i, j) == esc(i-1, j+1) + 1
                p = '1';
            end
        end
    end
    if i-1 >= 1 % вверх
        if esc(i, j) == esc(i-1, j) + 1
            p = 'u';
        end
    end
    if j+1 <= m % вправо
        if esc(i, j) == esc(i, j+1) + 1
            p = 'r';
        end
    end
    if var 
        if i+1 <= n && j+1 <= m %вправо вниз
            if esc(i, j) == esc(i+1, j+1) + 1
                p = '2';
            end
        end
    end
    if i+1 <= n %вниз
        if esc(i, j) == esc(i+1, j) + 1
            p = 'd';
        end
    end
    if var 
        if i-1 >= 1 && j-1 >= 1 % вверх влево
            if esc(i, j) == esc(i-1, j-1) + 1
                p = '3';
            end
        end
    end
    if j-1 >= 1 % влево
        if esc(i, j) == esc(i, j-1) + 1
            p ='l';
        end
    end
    if var
        if i+1 <= n && j-1 >= 1 % вниз влево
            if esc(i, j) == esc(i+1, j-1) + 1
                p = '4';
            end
        end
    end
    dir = [dir p];
    %dir = p;
    assignin("base", 'dir', dir);
%     switch p
%         case '1'
%             Path([i-1 j+1], var);
%         case 'u'
%             Path([i-1 j], var);
%         case 'r'
%             Path([i j+1], var);
%         case '2'
%             Path([i+1 j+1], var);
%         case 'd'
%             Path([i+1 j], var);
%         case '3'
%             Path([i-1 j-1], var);
%         case 'l'
%             Path([i j-1], var);
%         case '4'
%             Path([i+1 j-1], var);
%         otherwise 
%             disp('No Escape');
%             return;
%     end
    if p == '1'
        Path([i-1 j+1], var);
    elseif p =='u'
        Path([i-1 j], var);
    elseif p == 'r'
        Path([i j+1], var);
    elseif p == '2'
        Path([i+1 j+1], var);
    elseif p == 'd'
        Path([i+1 j], var);
    elseif p == '3'
        Path([i-1 j-1], var);
    elseif p == 'l'
        Path([i j-1], var);
    elseif p == '4'
        Path([i+1 j-1], var);
    end
end
            
                
    
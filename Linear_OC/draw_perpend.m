function point = draw_perpend(a, b, c, x, y)
    if y - x == b - a + c
        point = [x - 0.5/sqrt(2), y + 0.5/sqrt(2)];
    elseif y + x == b + a - c
        point = [x - 0.5/sqrt(2), y - 0.5/sqrt(2)];
    elseif y - x == b - a - c
        point = [x + 0.5/sqrt(2), y - 0.5/sqrt(2)];
    %elseif y + x == b + c + a
    else
        point = [x + 0.25/sqrt(2), y + 0.25/sqrt(2)];
        disp('else');
    end
end





function f = func2(t)
    f = (t.^2 - t) .* exp(-abs(t));
end
function extern = DrawP(rho, N)
    val = zeros(N, 1); % столбец значений
    point = zeros(N, 2); % матрица координат опорных векторов
    phi = linspace(0, 2* pi, N); 
    x = zeros(2, N);
    extern = zeros(N, 2);
    for i = 1: N
        x(:, i) = [cos(phi(i)), sin(phi(i))];
        [val(i), point(i, :)] = rho(x(:, i));
    end
    for i = 2: N
        prev = x(:, i - 1);
        l = x(:, i);
        extern(i - 1, 2) = (val(i) * prev(1) - val(i - 1) * l(1)) / (l(2) * prev(1) - prev(2) * l(1));
        extern(i - 1, 1) = (val(i - 1) - prev(2) * extern(i - 1, 2)) / prev(1);
    end 
%     extern(N, 2) = (val(1) * x(N, 1) - val(N) * x(1, 1)) / (x(1, 2) * x(N, 1) - x(N, 2) * x(1, 1));
%     extern(N, 1) = (val(N) - x(N, 2) * extern(N, 2)) / x(N, 1);
     extern(N, 1) = extern(1, 1);
     extern(N, 2) = extern(1, 2);
    point(1, 1) = point(N, 1);
    point(1, 2) = point(N, 2);
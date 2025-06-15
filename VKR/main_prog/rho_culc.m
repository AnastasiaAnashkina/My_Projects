function rho = rho_culc(r, k, w, K_all, H, beta)
    alpha = 0.3;
    s = 1.2;
    %x = (r * k + w) / (K_all + H * w);
    x = (r * k + w) / K_all;
    %disp("x = ");
    %disp(x);
    %disp(K_all);
    rho = r * (beta + (s - beta) * (1 - x)^alpha);
    %rho = r * (beta + (s - beta) * exp(-10 * x));
    %rho = r * (beta + (s - beta) * log(1 + (K_all + H*w / (r * k + w))));
    
    
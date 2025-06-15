function k0 = gen_k(H, min_val, max_val)
    k0 = min_val + (max_val - min_val) * rand(1, H);
    %k0 = sort(k0, 'descend');
    k0 = sort(k0);
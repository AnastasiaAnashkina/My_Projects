function [val, point] = P_rho(l, sig, eta)
    l1 = l(1, :);
    l2 = l(2, :);
    const1 = sqrt(sig * eta ./ (l1.^2 + sig * l2.^2));
    const2 = sqrt(sig * eta ./ (sig * l1.^2 + l2.^2));
    const3 = sqrt(eta ./ (1 + sig));
    res1 = sqrt(eta ./ sig .* l1.^2 + eta .* l2.^2);
    res2 = sqrt(eta .* l1.^2 + eta / sig .* l2.^2);
    if sig > 1
        if abs(l2) < 1 / sig * abs(l1)
            val = res1;
            point = [l1 ./ sig .* const1; l2 .* const1];
        elseif abs(l2) > sig * abs(l1)
            val = res2;
            point = [l1 .* const2; l2 ./ sig .* const2];
        else 
            val = const3 .* (abs(l1) + abs(l2));
            point = [sign(l1) .* const3; sign(l2) .* const3];
        end
    else 
        if abs(l2) > 1 / sig * abs(l1)
            val = res1;
            point = [l1 ./ sig .* const1; l2 .* const1];
        elseif abs(l2) < sig * abs(l1)
            val = res2;
            point = [l1 .* const2; l2 ./ sig .* const2];
        else 
            val = const3 .* (abs(l1) + abs(l2));
            point = [sign(l1) .* const3; sign(l2) .* const3];
        end
    end
    
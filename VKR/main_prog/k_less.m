function dydt = k_less(t, y, r, w, c)
    dydt = r * y + w - c;
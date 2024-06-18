function [t, psi] = psi_decition(A, psi0,t0, time)
    tspan = [t0 time];
    A = transpose(A);
    [t, psi] = ode45(@(t, psi) -A*psi, tspan, psi0);
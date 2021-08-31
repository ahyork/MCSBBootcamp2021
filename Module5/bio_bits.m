% constants
k_A_on = 10;
k_A_off = 10;
k_I_on = 10;
k_I_off = 10;
k_I_cat = 10;
k_A_cat = 100;
P_tot = 1.0;

% starting conditions
A_start = 0.0;
I_start = 100.0;
AP_start = 0.0;
IK_start = 0.0;

active_ss = zeros(1, 6);

for i = 1:6
    K_tot = 10 ^ (i - 4);

    % equations
    dAdt  =@(A, I, AP, IK) -k_A_on * (P_tot - AP) * A + k_A_off * AP + k_A_cat * IK;
    dIdt  =@(A, I, AP, IK) -k_I_on * (K_tot - IK) * I + k_I_off * IK + k_I_cat * AP;
    dAPdt =@(A, I, AP, IK) k_A_on * (P_tot - AP) * A - k_A_off * AP - k_I_cat * AP;
    dIKdt =@(A, I, AP, IK) k_I_on * (K_tot - IK) * I - k_I_off * IK - k_A_cat * IK;

    [T, X] = ode45(@(t, x)[dAdt(x(1), x(2), x(3), x(4)),
                           dIdt(x(1), x(2), x(3), x(4)),
                           dAPdt(x(1), x(2), x(3), x(4)),
                           dIKdt(x(1), x(2), x(3), x(4))],
                  [0, 2], [A_start, I_start, AP_start, IK_start]);

    active_ss(i) = X(end, 1);
end

figure(1); hold on;
semilogx(10 .^ (-3:2), active_ss)


%figure(1); hold on;
%plot(T, X(:, 1), '-g')
%plot(T, X(:, 2), '-r')
%plot(T, X(:, 3), '-b')
%plot(T, X(:, 4), '-m')
%xlabel('Time (s)')
%ylabel('Concentration (uM)')

pause()

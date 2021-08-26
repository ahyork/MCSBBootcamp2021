A = 1.1;        % fluorescence intensity units
omega = 2.6;    % rad / s
A_0 = 0.01;

u=@(t) A * sin(omega * t) + A_0;

tArray = linspace(0, 1.6, 200);
uExact = u(tArray);     % array of samples of u - exact

% Analytical solutions
dudt_exact = A * omega * cos(omega * tArray);
max_dudt_exact = max(dudt_exact);
du2dt2_exact = -A * omega ^ 2 * sin(omega * tArray);
max_du2dt2_exact = max(du2dt2_exact);
du3dt3_exact = -A * omega ^ 3 * cos(omega * tArray);
max_du3dt3_exact = max(du3dt3_exact);

for i = -1:-1:-15
    % add noise to the sample
    sigma = 10^i;
    uArray = u(tArray) + sigma * randn(size(tArray));

    %plot(tArray, uArray, '.')
    %pause()

    % generate our estimated dudt
    t_step = tArray(2) - tArray(1);
    dudt_est = diff(uArray) ./ t_step;
    du2dt2_est = diff(dudt_est) ./ t_step;
    du3dt3_est = diff(du2dt2_est) ./ t_step;

    dudt_error = max(abs(dudt_est .- dudt_exact(1:end - 1)) / max_dudt_exact)
    du2dt2_error = max(abs(du2dt2_est .- du2dt2_exact(1:end - 2)) / max_du2dt2_exact)
    du3dt3_error = max(abs(du3dt3_est .- du3dt3_exact(1:end - 3)) / max_du3dt3_exact)

    if [dudt_error, du2dt2_error, du3dt3_error] < 0.1
        display(i)
        break;
    end
end

figure(1);
subplot(3, 1, 1); hold on;
plot(tArray(1:end - 1), dudt_est, '-b')
plot(tArray(1:end - 1), dudt_exact(1:end - 1), '--r')
xlabel('t')
ylabel('du/dt')

subplot(3, 1, 2); hold on;
plot(tArray(1:end - 2), du2dt2_est, '-b')
plot(tArray(1:end - 2), du2dt2_exact(1:end - 2), '--r')
xlabel('t')
ylabel('d2u/dt2')

subplot(3, 1, 3); hold on;
plot(tArray(1:end - 3), du3dt3_est, '-b')
plot(tArray(1:end - 3), du3dt3_exact(1:end - 3), '--r')
xlabel('t')
ylabel('d3u/dt3')

pause()

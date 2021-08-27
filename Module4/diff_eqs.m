a_0 = 500;          % molecules per hour
a_1 = 0.5;          % molecules / hour / existing molecule
b = 4;              % 1 / hour
dPdt =@(P) (a_0 + a_1 * P) - b * P;

% find the steady state by plotting dPdt versus P
PArray = linspace(0, 200, 200);
dPdtPhaseLine = dPdt(PArray);

figure(1); hold on;
plot(PArray, dPdtPhaseLine, 'r');
ylabel('dP/dt');
xlabel('P');
plot(PArray, zeros(1, 200));
legend('dPdt Phase Line', 'Reference Line');

pause()

% numerically find the steady state
[T, P] = ode45(@(t, x)dPdt(x), [0, 2.0], 0);

display(P(end))

figure(2); hold on;
plot(T, P, '-r')
plot(T, zeros(1, length(T)) + 142.86, '--b')

pause()

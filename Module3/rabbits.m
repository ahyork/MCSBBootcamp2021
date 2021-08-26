% define constants for use in the rabbit population growth equation
r = 2.35;         % the growth rate
K = 0.6;         % the carrying capacity
starting_pop = 0.2;      % the starting population for the rabbits

n_mid = 30;
n_max = n_mid * 2;
n_range = n_max-n_mid:n_max

figure(1);

for r = 0.1:0.01:3.0

    x = zeros(1, n_max);
    x(1) = starting_pop;

    for t = 1:n_max
        x(t + 1) = x(t) + r * (1 - x(t) / K) * x(t);
    end

    plot(zeros(1, length(n_range)) + r, x(n_range), '.k')
    %plot(x(n_range), '.k')
    %plot(x, '-ok')
    hold on

end

hold off

ylabel('Population (thousands)')
xlabel('time (months)')
pause()
display(x)

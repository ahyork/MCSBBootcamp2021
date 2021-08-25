% define constants for use in the rabbit population growth equation
r = 2.1;         % the growth rate
K = 0.6;         % the carrying capacity
starting_pop = 0.2;      % the starting population for the rabbits

num_time_steps = 50;

x = zeros(1, num_time_steps);
x(1) = starting_pop;

for t = 1:num_time_steps
    x(t + 1) = x(t) + r * (1 - x(t) / K) * x(t);
end

figure(1);
plot(x, '-ok')
ylabel('Population (thousands)')
xlabel('time (months)')
pause()

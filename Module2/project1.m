% How much caffeine is there in the jar?

% n - number of days
% x - fraction of caffeinated 

size = 22; % max number of days to simulate
c = -0.8;    % given constant for the equation
d = 0.156;   % given constant for the equation

NStartingPoints = 1e5;  % define the number of random starting points we use
min_start = -2;
max_start = 2;

x_starts = (max_start - min_start) * rand(1, NStartingPoints) .+ min_start
y_starts = (max_start - min_start) * rand(1, NStartingPoints) .+ min_start

figure(1);
plot(x_starts, y_starts, 'ok')
ylabel('y initials')
xlabel('x initials')
pause()

within_bounds = false(1, NStartingPoints)

for i = 1:NStartingPoints
    % define arrays for storing the information
    x = zeros(1, size)
    y = zeros(1, size)
    % set starting conditions for the arrays
    x(1) = x_starts(i)
    y(1) = y_starts(i)

    for n=2:size
        x(n) = x(n - 1) ^ 2 - y(n - 1) ^ 2 + c;
        y(n) = 2 * x(n - 1) * y(n - 1) + d;
    end % finished loop through days

    within_bounds(i) = abs(x(22)) < 2 && abs(y(22)) < 2;
end % loop through different starting points

% THE MODEL ^
% ------------------------------------------
% THE BEHAVIOR / THE OUTPUT ? 

% plot the starting points with colors to show if they converge or not
figure(2);
plot(x_starts(within_bounds), y_starts(within_bounds), 'ob')
hold on
plot(x_starts(!within_bounds), y_starts(!within_bounds), 'or')
hold off
ylabel('y initials')
xlabel('x initials')
pause()

% x(n) and y(n) versus n
%figure(3); 
%plot(x,'-or');
%hold on
%plot(y,'-ob');
%hold off
%ylabel('output')
%xlabel('n')
%pause()

% y(n) v x(n)
%figure(4);
%plot(x, y, '-ok')
%ylabel('y(n)')
%xlabel('x(n)')
%pause();

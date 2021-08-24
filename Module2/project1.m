% How much caffeine is there in the jar?

% n - number of days
% x - fraction of caffeinated 

size = 22; % max number of days to simulate
c = -0.8    % given constant for the equation
d = 0.156   % given constant for the equation

% define arrays for storing the information
x = zeros(1, size)
y = zeros(1, size)
% set starting conditions for the arrays
x(1) = 0.1
y(1) = 0.1

for n=2:size
    x(n) = x(n - 1) ^ 2 - y(n - 1) ^ 2 + c
    y(n) = 2 * x(n - 1) * y(n - 1) + d
end % finished loop through days

% THE MODEL ^
% ------------------------------------------
% THE BEHAVIOR / THE OUTPUT ? 

% x(n) and y(n) versus n
figure(1); 
plot(x,'-or');
hold on
plot(y,'-ob');
hold off
ylabel('output')
xlabel('n')
pause()

figure(2);
plot(x, y, '-ok')
ylabel('y(n)')
xlabel('x(n)')
pause();

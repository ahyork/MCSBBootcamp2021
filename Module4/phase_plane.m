% parameters
a = 0;
b = 2;
c = -2;
d = -1;

% 1. a=0, b=-2, c=2, d=1 || a=-1, b=-2, c=2, d=0 -> either derivative is only dependent on itself
% 2. a=-x, b=0, c=0, d=-x -> straight attraction
% 3. a=-1, b=0, c=2, d=1 || a=-1, b=-2, c=0, d=1 -> either derivative is only dependent on the other variable
% 4. a=x, b=0, c=0, d=x -> straight repulsions
% 5. a=-1, b=-2, c=2, d=1 -> 
% 6. a=1, b=2, c=2, d=1 -> saddle

% model equations
f =@(x, y) a * x + b * y;
g =@(x, y) c * x + d * y;

[T, X] = ode45(@(t, x)[f(x(1), x(2)); g(x(1), x(2))], [0, 1000], [.1, .1]);

figure(1); hold on;
set(gca, 'xlim', [-1, 1], 'ylim', [-1, 1])
ylabel('y')
xlabel('x')

xArray = linspace(-1, 1, 16);
yArray = linspace(-1, 1, 16);

[xMesh, yMesh] = meshgrid(xArray, yArray);

% Matlab arrow plot
quiver(xMesh, yMesh, f(xMesh, yMesh), g(xMesh, yMesh));

plot(X(:, 1), X(:, 2), '-r')
plot(X(end, 1), X(end, 2), 'or')

pause()

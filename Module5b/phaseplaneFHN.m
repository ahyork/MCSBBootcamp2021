% model parameters
eps = 0.08;
a = 0.5;
b = 0.2;
I_0 = 1.0;
tStart = 40;
tStop = 47;
D = 0.9;

% model definition
I =@(t) [ zeros(3, 1); I_0 * (t > tStart && t < tStop); zeros(6, 1) ];

f = @(v,w) v - 1/3*v.^3 - w;
g = @(v,w) eps*(v + a -b*w);

inter =@(x) D * (-2 * x(1:10) + [x(10); x(1:9)] + [x(2:10); x(1)]);

%% single cell
dxdt =@ (t,x) [f(x(1:10), x(11:20)) + I(t) + inter(x);
               g(x(1:10), x(11:20))
              ];

% solve!
% use for steady state i.e. a = 1.0
%[T,X] = ode45(dxdt,[0,100], [zeros(10, 1) - 1.5; zeros(10, 1) - 0.5]);

% use for oscillation i.e. a = 0.5
[T,X] = ode45(dxdt,[0, 100], 4 * rand(20, 1) - 2);



figure(1); hold on;
set(gca, 'xlim', [-2.5, 2.5], 'ylim', [-2.5,2.5])
ylabel('w');
xlabel('v')

uArray = linspace(-2.5, 2.5,32);
wArray = linspace(-2.5, 2.52,32);

[uMesh,wMesh] = meshgrid(uArray, wArray);

% the Matlab plot command for a field of arrows is:
quiver(uMesh, wMesh, f(uMesh, wMesh), g(uMesh,wMesh), 0.5)

c = ['r', 'b', 'c', 'm', 'g', 'k', 'y', 'c', 'b', 'r'];

for i = 1:10
    plot(X(:, i), X(:, 10 + i), ['-', c(i)])
    plot(X(end, i), X(end, 10 + i), ['o', c(i)])
end

figure(2); hold on;
ylabel('v (red) || w (blue)');
xlabel('time');
for i = 1:10
    plot(T, X(:, i), ['-', c(i)]);
    plot(T, X(:, 10 + i), ['-', c(i)]);
end

for nt = 1:numel(T)
    figure(3); clf; hold on; box on;
    plot(X(nt, 1:10));
    set(gca, 'ylim', [-2.5, 2.5]);
    title(sprintf('Current Time: %0.2f', T(nt)));
    xlabel('Cell');
    ylabel('Voltage');
    drawnow;
end
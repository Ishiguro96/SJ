%{
Wywolanie w kodzie
==== Zadanie 2 ====
x_min = -5;
x_max = 5;
px = x_min:0.01:x_max;
fun = @(x)0.1*(x.^4 - 20*x.^2 + 5*x);
A = [1; -1];
b = [5; 5];

==== Zadanie 3 ====
mi = 0;
x_min = -5;
x_max = 5;
px = x_min:0.01:x_max;
A = [1; -1];
b = [5; 5];

for n=1:4
    switch(n)
        case 1
            sigma = 0.0025;
        case 2
            sigma = 0.01;
        case 3
            sigma = 0.25;
        case 4
            sigma = 1;
    end

    fun = @(x)0.1*(x.^4 - 20*x.^2 + 5*x) + (randn(size(x)) .* sigma + mi);
    find_and_plot(px, fun, A, b, 5);
    title(['Function with noise N(', num2str(mi), ', ', num2str(sigma), ')']);

end
%}

function find_and_plot(px, fun, A, b, iters)

% Generate plot for function
py = fun(px);
figure;
plot(px, py, 'k', 'DisplayName', 'Function'); % Display function

% Create arrays to hold variables
x_rnd = zeros(iters, 1);
x0 = zeros(iters, 1);
y0 = zeros(iters, 1);
elapsed = zeros(iters, 1);

% Find iters-times minimum of function starting from random point
for i=1:iters
    x_rnd(i) = px(1) + (px(end)-px(1)) * rand(1,1);
    tic
    [x0(i), y0(i)] = fmincon(fun, x_rnd(i), A, b);
    elapsed(i) = toc;
end

% Sort arrays by elapsed time
[elapsed, sort_index] = sort(elapsed);
x_rnd = x_rnd(sort_index);
x0 = x0(sort_index);
y0 = y0(sort_index);

% Plot random Xs and calculated Ys with info in legend
hold on;
for i=1:iters
    plot(x_rnd(i), fun(x_rnd(i)), 'x', 'DisplayName', ['x = ', num2str(x_rnd(i),3), ' Time elapsed = ', num2str(elapsed(i),3)], 'MarkerSize', 20);
    plot(x0(i), y0(i), '.', 'DisplayName', ['Optimal point for x = ', num2str(x_rnd(i),3), ' is (', num2str(x0(i),3), ', ', num2str(y0(i),3), ')'], 'MarkerSize', 20);
end
hold off;

% Show legend and set some settings
legend(gca, 'show')
lgd = legend;
lgd.FontSize = 12;

end

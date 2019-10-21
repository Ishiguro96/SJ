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
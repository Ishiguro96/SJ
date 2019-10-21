function find_and_plot_2d(px, fun, A, b, iters)

% Generate plot for function
[~, max_iter] = size(px);
Z = zeros(max_iter, max_iter);
for i = 1:max_iter
    for j = 1:max_iter
        x = [px(1,i); px(2,j)];
        Z(i,j) = fun(x);
    end
end

figure;
mesh(px(1,:), px(2,:), Z, 'DisplayName', 'Function');

% Create arrays to hold variables
x_rnd = zeros(2, iters);
x0 = zeros(2, iters);
z0 = zeros(iters, 1);
elapsed = zeros(iters, 1);

% Find iters-times minimum of function starting from random point
for i=1:iters
    x_rnd(1,i) = min(min(px)) + (max(max(px))-min(min(px))) * rand(1,1);
    x_rnd(2,i) = min(min(px)) + (max(max(px))-min(min(px))) * rand(1,1);
    tic
    [x0(:,i), z0(i)] = fmincon(fun, x_rnd(:,i), A, b);
    elapsed(i) = toc;
end

% Sort arrays by elapsed time
%[elapsed, sort_index] = sort(elapsed);
%x_rnd = x_rnd(sort_index);
%x0 = x0(sort_index);
%y0 = y0(sort_index);

% Plot random Xs and calculated Ys with info in legend
hold on;
for i=1:iters
    scatter3(x_rnd(1,i), x_rnd(2,i), fun([x_rnd(1,i) x_rnd(2,i)]), 1000, '*', 'DisplayName', ['x1 = ', num2str(x_rnd(1,i),3), ' x2 = ', num2str(x_rnd(2,i),3), ' Time elapsed = ', num2str(elapsed(i),3)]);
    scatter3(x0(1,i), x0(2,i), z0(i), 2000, '.', 'DisplayName', ['Optimal point for x1 = ', num2str(x_rnd(1, i),3), ' x2 = ', num2str(x_rnd(2,i),3),' is (', num2str(x0(1, i),3), ', ', num2str(x0(2, i),3), ', ', num2str(z0(i),3), ')']);
end
hold off;

% Show legend and set some settings
legend(gca, 'show')
lgd = legend;
lgd.FontSize = 12;

end
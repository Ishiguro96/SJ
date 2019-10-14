% =====================
% |      SJ LAB 2     |
% |       SEM 7       |
% | Dawid Tobor gr. 4 |
% =====================

close all
clear variables
clc

zadanie = 5;

switch(zadanie)
    case 1 % Zad 1
        K = 1;
        N = 100;
        
        px = K:N;
        py = zeros(K,1);
        
        p = prob(0.001, K, N);
        disp(p);
        
        for i = 1:N
            py(i) = prob(0.001, i, N);
        end
        
        plot(px, py);
        
    case 2 % Zad 2
        X = randn(500000, 1);
        p = prob_norm(X, 0, 1, 3);
        p2 = prob_norm_find(X, 0, 1, 0.0028, 0.001);
        disp(p);
        disp(p2);
       
    case 3 % Zad 3
        X = randn(500, 1);
        X2 = rand(500,1);
        %plot(x,y);
        check_dist(X)
        check_dist(X2)

    case 4 % Zad 4
        px = 1:26;
        s1 = zeros(6,1);
        s2 = zeros(6,1);
        s3 = zeros(6,1);
        for i = 1:26
            X = randn(10, i); % K x N
            [s1(i), s2(i), s3(i)] = est(X);
        end
        figure;
        plot(px, s1, px, s2, px, s3);
        
    case 5 % Zad 5
        mi = 0;
        sigma = 1;
        
        N1 = 200;
        N2 = 1000;
        N3 = 10000;
        N4 = 100000;
        
        X1 = randn(N1, 1) * sigma + mi;
        X2 = randn(N2, 1) * sigma + mi;
        X3 = randn(N3, 1) * sigma + mi;
        X4 = randn(N4, 1) * sigma + mi;
        
        comp_hist(X1, 20);
        
        [py1, px1] = ecdf(X1);
        [py2, px2] = ecdf(X2);
        [py3, px3] = ecdf(X3);
        [py4, px4] = ecdf(X4);
        
        % Calculate cdf
        x = -4:.01:4;
        p = normcdf(x);
        h = figure;
        hold on;
        plot(x, p);
        plot(px1, py1);
        plot(px2, py2);
        plot(px3, py3);
        plot(px4, py4);
        hold off;
        
        legend({'Idealna dystrybuanta', ...
            ['N = ', num2str(N1)], ...
            ['N = ', num2str(N2)], ...
            ['N = ', num2str(N3)], ...
            ['N = ', num2str(N4)]});
        
        
end
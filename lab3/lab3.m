% =====================
% |      SJ LAB 3     |
% |       SEM 7       |
% | Dawid Tobor gr. 4 |
% =====================

close all
clear variables
clc

zadanie = 5;

% =========================== %
% Zadanie 1 - funkcje matlaba
% -> fminbnd(fun, x1, x2) - zwraca skalarnie 
%      minimum funkcji w x1<x<x2
% -> fminsearch(fun, x0) - nieliniowa funkcja szukajaca minimum
% -> fmincon(fun, x0, A, b) - nieliniowa funkcja szukajaca minimum
%      A - macierz opisujaca mnozniki przy X
%      b - macierz wynikowa
%      Ax <= b
% -> nlinfit(X, Y, modelfun, beta0) - regresja nieliniowa
%      X, Y - dane wartosci (predyktory)
%      modelfun - model funkcji nieliowej
%      beta0 - startowe wartosci wspolczynnikow dla
%        algorytmu najmniejszych kwadratów
% =========================== %

switch(zadanie)
    case 2
        % Settings for searching
        x_min = -5;
        x_max = 5;
        px = x_min:0.01:x_max;
        fun = @(x)0.1*(x.^4 - 20*x.^2 + 5*x);
        A = [1; -1];
        b = [5; 5];
        
        find_and_plot(px, fun, A, b, 4);
        
    case 3
        % Settings for searching
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
        
    case 4
        % WITHOUT NOISE
        % Settings for searching
        x_min = [0; 0];
        x_max = [12; 12];
        px1 = x_min(1):0.1:x_max(1);
        px2 = x_min(2):0.1:x_max(2);
        px = [px1; px2];
        fun = @(x)x(1).*sin(x(1)) + x(2).*sin(x(2));
        
        A = [-1 0; 1 0; 0 -1; 0 1];
        b = [0 12 0 12];
        
        find_and_plot_2d(px, fun, A, b, 3);
        
        % WITH NOISE
        mi = 0;
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
            
            [sx1, sx2] = size(px);
            fun = @(x)x(1).*sin(x(1)) + x(2).*sin(x(2)) + (randn(1,1) .* sigma + mi);
            find_and_plot_2d(px, fun, A, b, 5);
            title(['Function with noise N(', num2str(mi), ', ', num2str(sigma), ')']);

        end
        
    case 5
        T = [23.6; 30; 37.5; 44; 50; 57; 64; 70; 75];
        T = T + 273.15;
        R = [10.5; 8.05; 6.1; 4.78; 3.88; 2.98; 2.34; 1.93; 1.64];
        
        % Linear regression
        x = 1./T;
        y = log(R);
        [A, B] = lin_reg(x, y);
        
        px = T(1):0.1:T(end);
        py = A*exp(B./px);
        
        % Comparison
        figure;
        hold on;
        plot(T, R, 'd');
        plot(px, py);
        
        ERR1 = zeros(9,1);
        for i = 1:9
            ind = find(px == T(i));
            ERR1(i) = (py(ind) - R(i)).^2;
        end
        % Non-linear regression
        J = @(P)sum((R(1:9) - P(1).*exp(P(2)./T(1:9))).^2);
        P = fminsearch(J, [A B]);
        
        fun = @(P,X)P(1)*exp(P(2)./X);
        y = fun(P,px);
        
        beta = nlinfit(px, y, fun, [1 1]);
        pyyy = beta(1).*exp(beta(2)./px);
        
        plot(px, pyyy, '--');
        
        ERR2 = zeros(9,1);
        for i = 1:9
            ind = find(px == T(i));
            ERR2(i) = (pyyy(ind) - R(i)).^2;
        end
        
        ERR = [ERR1 ERR2];
        
        legend({'Wartosci mierzone', 'Wartosci z regresji liniowej', 'Wartosci z regresji nieliniowej'});
        xlim([min(T) max(T)]);
        
    case 6
        model = @(P,X)P(1)*exp(-(X - P(2)).^2 ./ (2*P(3)*P(3)));
        
        P = [1 50 10]; %[h b c]
        mi = 0;
        sigma = 0.00001 * P(2);
        
        x = 1:1:100;
        y = model(P,x);
        y = y + randn(1,100).*sigma + mi;
        
        [beta, R, J] = nlinfit(x, y, model, [0.9 38 6]);
        CI = nlparci(beta, R, 'jacobian', J)
        
        py = model(beta,x);
        
        figure;
        hold on;
        plot(x,y);
        plot(x, py);
        hold off;
end
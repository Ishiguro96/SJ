%%
% Zadanie 1
%

function [test_out_value, critical_value, decision] = ...
    sig_level_avg(sig_level, X, avg_tested, type_of_test, plot_result)

if ~exist('plot_result', 'var')
    plot_result = false;
end

mi = mean(X);
sigma = std(X);
[n, ~] = size(X);

test_out_value = (mi - avg_tested)/sigma * sqrt(n);

switch(type_of_test)
    case 'left sided'
        critical_value = -norminv(1-sig_level, 0, 1);
        if(test_out_value <= critical_value)
            decision = false;
        else
            decision = true;
        end
    case 'right sided'
        critical_value = norminv(1-sig_level, 0, 1);
        if(test_out_value >= critical_value)
            decision = false;
        else
            decision = true;
        end
    case 'bilateral'
        critical_value = norminv(1-(sig_level/2), 0, 1);
        critical_value_neg = -norminv(1-(sig_level/2), 0, 1);
        if(test_out_value <= critical_value_neg || test_out_value >= critical_value)
            decision = false;
        else
            decision = true;
        end
    otherwise
        disp('Wrong method has been chosed!');
        test_out_value = 0;
        critical_value = 0;
        decision = false;
        return
end

end


%%
% Zadanie 2
%

function [test_out_value, critical_value, decision] = ...
    sig_level2_avg(sig_level, X1, X2, type_of_test, plot_result)

if ~exist('plot_result', 'var')
    plot_result = false;
end

mi = [mean(X1) mean(X2)];
sigma = [std(X1) std(X2)];
[n1, ~] = size(X1);
[n2, ~] = size(X2);

test_out_value = (mi(1)-mi(2)) / sqrt(sigma(1)^2 / n1 + sigma(2)^2 / n2);% u

switch(type_of_test)
    case 'left sided'
        critical_value = -norminv(1-sig_level, 0, 1);
        if(test_out_value <= critical_value)
            decision = false;
        else
            decision = true;
        end
    case 'right sided'
        critical_value = norminv(1-sig_level, 0, 1);
        if(test_out_value >= critical_value)
            decision = false;
        else
            decision = true;
        end
    case 'bilateral'
        critical_value = norminv(1-(sig_level/2), 0, 1);
        critical_value_neg = -norminv(1-(sig_level/2), 0, 1);
        if(test_out_value <= critical_value_neg || test_out_value >= critical_value)
            decision = false;
        else
            decision = true;
        end
    otherwise
        disp('Wrong method has been chosed!');
        test_out_value = 0;
        critical_value = 0;
        decision = false;
        return
end
end


%%
% Zadanie 3
%

function [test_out_value, critical_value, decision] = ...
    sig_level_var(sig_level, X, var_tested, type_of_test, plot_result)

if ~exist('plot_result', 'var')
    plot_result = false;
end

sigma = std(X);
[n, ~] = size(X);

test_out_value = (n * sigma^2) / var_tested; % chi-square

switch(type_of_test)
    case 'left sided'
        critical_value = -chi2inv(1-sig_level, n-1);
        if(test_out_value <= critical_value)
            decision = false;
        else
            decision = true;
        end
    case 'right sided'
        critical_value = chi2inv(1-sig_level, n-1);
        if(test_out_value >= critical_value)
            decision = false;
        else
            decision = true;
        end
    case 'bilateral'
        critical_value = chi2inv(1-(sig_level/2), n-1);
        critical_value_neg = -chi2inv(1-(sig_level/2), n-1);
        if(test_out_value <= critical_value_neg || test_out_value >= critical_value)
            decision = false;
        else
            decision = true;
        end
    otherwise
        disp('Wrong method has been chosed!');
        test_out_value = 0;
        critical_value = 0;
        decision = false;
        return
end
end
%%
% Zadanie 1
%%

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
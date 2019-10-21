function [A, B] = lin_reg(x, y)
    figure;
    hold on;
    scatter(x, y)
    p = polyfit(x,y,1);
    a = p(1);
    b = p(2);
    py = a.*x + b;
    plot(x, py)
    
    A = exp(b);
    B = a;
    
    hold off;
    
    legend({'Wartosci mierzone', 'Regresja liniowa'});
    xlim([min(x) max(x)]);
end
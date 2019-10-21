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
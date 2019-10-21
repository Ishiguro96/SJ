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
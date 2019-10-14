function check_dist(X)

[N, ~] = size(X);

X = sort(X);
X = zscore(X); % normalize

Y = zeros(N, 1);
for i = 1:N
    p = (i-0.5)/N;
    Y(i) = norminv(p);
end

figure;
plot(X, Y);

end
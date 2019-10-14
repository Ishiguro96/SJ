function out_k = prob_norm_find (X, mi, sigma, P, step)

X = X * sigma + mi;
val = abs((X - mi) / sigma);

out_k = mi + 3;
prob = 0;
eps = 0.001;

while (prob < P - eps || prob > P + eps)
    out_k = out_k - step;
    [nmax, ~] = size(val);
    [n, ~] = size(find(val > out_k));

    prob = n/nmax;
end

end
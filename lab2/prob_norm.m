function out_probability = prob_norm (X, mi, sigma, k)

X = X * sigma + mi;

val = abs((X - mi) / sigma);

[nmax, ~] = size(val);
[n, ~] = size(find(val > k));

out_probability = n/nmax * 100;

end
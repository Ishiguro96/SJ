function out_probability = prob (p, K, N)

out_probability = 0;
for i = K:N
    out_probability = out_probability + (nchoosek(N, i) * power(p, i) * power((1- p), (N - i)));
end

end
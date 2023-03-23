d = 0.85;

I = speye(N);
value = (1-d)/N;
b = value(ones(N, 1));
[numRowsE, numColsE] = size(Edges);

w1 = Edges(1, :);
w2 = Edges(2, :);
w3 = ones(1, numColsE);

B = sparse(w2, w1, w3, N, N);

L = zeros(1, N);
for i = 1:N
    L(i) = sum(B(:, i));
end

A = speye(N)./L;
save zadB_184440 A B I b
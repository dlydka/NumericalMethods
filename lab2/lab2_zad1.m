Edges = [1 1 2 2 2 3 3 3 4 4 5 5 6 6 7;
         4 6 3 4 5 5 6 7 5 6 4 6 4 7 6];

N = 7;
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
M = sparse(I - d*B*A);

r = M\b;

bar(r);

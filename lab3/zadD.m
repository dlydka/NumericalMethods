clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];
d = 0.85;
density = 10;

for i = 1:5
    [Edges] = generate_network(N(i), density);
    I = speye(N(i));
    value = (1-d)/N(i);
    b = value(ones(N(i), 1));
    [numRowsE, numColsE] = size(Edges);
    
    w1 = Edges(1, :);
    w2 = Edges(2, :);
    w3 = ones(1, numColsE);
    
    B = sparse(w2, w1, w3, N(i), N(i));
    
    L = zeros(1, N(i));
    for j = 1:N(i)
        L(j) = sum(B(:, j));
    end
    
    A = speye(N(i))./L;
    M = sparse(I - d*B*A);
    tic
    r = M\b;
    czas_Gauss(i) = toc;
end

plot(N, czas_Gauss);
title("Zadanie D - czas bezpośredniego rozwiązania");
ylabel("Czas [s]");
xlabel("Rozmiar macierzy");
saveas(gcf, 'zadD_184440.png');

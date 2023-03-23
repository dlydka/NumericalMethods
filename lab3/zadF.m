clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];
d = 0.85;
density = 10;
stop = 10^(-14);

for i = 1:5
    counting = true;
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

    r = ones(N(i), 1);
    L = tril(M, -1);
    U = triu(M, 1);
    D = diag(diag(M));
    
    comp1 = -(D+L);
    comp2 = (D+L)\b;

    iterations(i) = 0;
    k = 1;
    res = 1;
    tic
    while counting == true
        if N(i)==1000
            normres(k) = norm(res);
            k = k + 1;
        end
        iterations(i) = iterations(i) + 1;
        r = comp1\(U*r) + comp2;
        res = M*r - b;
        
        if (norm(res) <= stop)
            counting = false;
        end
    end
    czas_Gauss_Seidl(i) = toc;
end

figure();
plot(N, czas_Gauss_Seidl);
title("Zadanie F - czas rozwiązania metodą Gaussa-Seidla");
ylabel("Czas [s]");
xlabel("Rozmiar macierzy");
saveas(gcf, 'zadF_184440_1.png');

figure();
plot(N, iterations)
title("Zadanie F - liczba iteracji potrzebnych do rozwiązania - Gauss-Seidl");
ylabel("Liczba iteracji");
xlabel("Rozmiar macierzy");
saveas(gcf, 'zadF_184440_2.png');

figure();
semilogy(normres);
title("Wykres normy błędu rezydualnego metody Gaussa-Seidla dla N = 1000");
xlabel("Ilosc iteracji");
ylabel("Norma residuum");
saveas(gcf, "zadF_184440_3.png");

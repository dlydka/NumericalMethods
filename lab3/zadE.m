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

    comp1 = -D\(L+U);
    comp2 = D\b;

    iterations(i) = 0;
    k = 1;
    res = 1;
    tic
    while counting == true
        if N(i)==1000
            norm_res(k) = norm(res);
            k = k + 1;
        end
        iterations(i) = iterations(i) + 1;
        r = comp1*r + comp2;
        res = M*r - b;
        
        if (norm(res) <= stop)
            counting = false;
        end
    end
    czas_Jacobi(i) = toc;
end

figure();
plot(N, czas_Jacobi);
title("Zadanie E - czas rozwiązania metodą Jacobi'ego");
ylabel("Czas [s]");
xlabel("Rozmiar macierzy");
saveas(gcf, 'zadE_184440_1.png');

figure();
plot(N, iterations)
title("Zadanie E - liczba iteracji potrzebnych do rozwiązania - Jacobi");
ylabel("Liczba iteracji");
xlabel("Rozmiar macierzy");
saveas(gcf, 'zadE_184440_2.png');

figure();
semilogy(norm_res);
title("Wykres normy błędu rezydualnego metody Jacobi'ego dla N = 1000");
xlabel("Ilosc iteracji");
ylabel("Norma residuum");
saveas(gcf, "zadE_184440_3.png");


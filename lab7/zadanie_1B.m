N = 10^7;
n = 5;
dx = n / N;
fmax = func(10);

mp = 0;
tic
for i = 1:N
    xi = (i - 1) * dx;
    xi1 = i * dx;
    mp = mp + func((xi + xi1) / 2) * dx;
end
czas_mp = toc;

mt = 0;
tic
for i = 1:N
    xi = (i - 1) * dx;
    xi1 = i * dx;
    mt = mt + (func(xi) + func(xi1)) / 2 * dx;
end
czas_mt = toc;

ms = 0;
tic
for i = 1:N
    xi = (i - 1) * dx;
    xi1 = i * dx;
    ms = ms + (func(xi) + 4 * func((xi + xi1) / 2) + func(xi1));
end
ms = ms * dx / 6;
czas_ms = toc;

mc = 0;
N1 = 0;
tic
for i = 1:N
    x = rand() * n;
       y = rand() * fmax;
       if y < func(x)
           N1 = N1 + 1;
       end
end
mc = N1 / N * n * fmax;
czas_mc = toc;

figure();
x = [1, 2, 3, 4];
y = [czas_mp, czas_mt, czas_ms, czas_mc];
bar(x, y, 0.5, 'FaceColor', [0, 0.5, 1]);
labels = {'prostokatow'; 'trapezow'; 'Simpsona'; 'Monte Carlo'};
set(gca, 'XTickLabel', labels);  
title('Czas wykonania poszczególnych metod dla N = 10^7');
xlabel('Metoda');
ylabel('Czas [s]');
saveas(gcf, "wykres_czasu_wykonania.png");

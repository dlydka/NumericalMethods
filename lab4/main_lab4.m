clc
clear all
close all

a = 1;   
b = 60000;
eps = 1e-3;

[xvect, xdif, fx, it_cnt] = bisect(a, b, eps, @compute_time);

figure();
plot(1:it_cnt, xvect)
title("Problem 1 - bisekcja - wartość kolejnego przybliżenia N w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych przybliżeń N");
saveas(gcf, 'zad1_wartosci_bisekcja.png');

figure();
semilogy(1:it_cnt, xdif)
title("Problem 1 - bisekcja - wartość kolejnych różnic N w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych różnic N");
saveas(gcf, 'zad1_roznice_bisekcja.png');

[xvect, xdif, fx, it_cnt] = secant(a, b, eps, @compute_time);

figure();
plot(1:it_cnt, xvect)
title("Problem 1 - sieczne - wartość kolejnego przybliżenia N w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych przybliżeń N");
saveas(gcf, 'zad1_wartosci_sieczne.png');

figure();
semilogy(1:it_cnt, xdif)
title("Problem 1 - sieczne - wartość kolejnych różnic N w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych różnic N");
saveas(gcf, 'zad1_roznice_sieczne.png');

a = 0;
b = 50;
eps = 1e-12;

[xvect, xdif, fx, it_cnt] = bisect(a, b, eps, @compute_impedance);

figure();
plot(1:it_cnt, xvect)
title("Problem 2 - bisekcja - wartość kolejnego przybliżenia impedancji w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych przybliżeń omega [Ω]");
saveas(gcf, 'zad2_wartosci_bisekcja.png');

figure();
semilogy(1:it_cnt, xdif)
title("Problem 2 - bisekcja - wartość kolejnych różnic impedancji w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych różnic omega [Ω]");
saveas(gcf, 'zad2_roznice_bisekcja.png');

[xvect, xdif, fx, it_cnt] = secant(a, b, eps, @compute_impedance);

figure();
plot(1:it_cnt, xvect)
title("Problem 2 - sieczne - wartość kolejnego przybliżenia impedancji w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych przybliżeń omega [Ω]");
saveas(gcf, 'zad2_wartosci_sieczne.png');

figure();
semilogy(1:it_cnt, xdif)
title("Problem 2 - sieczne - wartość kolejnych różnic impedancji w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych różnic omega [Ω]");
saveas(gcf, 'zad2_roznice_sieczne.png');

[xvect, xdif, fx, it_cnt] = bisect(a, b, eps, @compute_velocity);

figure();
plot(1:it_cnt, xvect)
title("Problem 3 - bisekcja - wartość kolejnego przybliżenia predkości w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych przybliżeń predkości [m/s]");
saveas(gcf, 'zad3_wartosci_bisekcja.png');

figure();
semilogy(1:it_cnt, xdif)
title("Problem 3 - bisekcja - wartość kolejnych różnic predkości w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych różnic predkości [m/s]");
saveas(gcf, 'zad3_roznice_bisekcja.png');

[xvect, xdif, fx, it_cnt] = secant(a, b, eps, @compute_velocity);

figure();
plot(1:it_cnt, xvect)
title("Problem 3 - sieczne - wartość kolejnego przybliżenia predkości w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych przybliżeń predkości [m/s]");
saveas(gcf, 'zad3_wartosci_sieczne.png');

figure();
semilogy(1:it_cnt, xdif)
title("Problem 3 - sieczne - wartość kolejnych różnic predkości w kolejnych iteracjach");
xlabel("Numer iteracji");
ylabel("Wartość kolejnych różnic predkości [m/s]");
saveas(gcf, 'zad3_roznice_sieczne.png');

options = optimset('Display','iter');
fzero(@tan, 6, options);
fzero(@tan, 4.5, options);


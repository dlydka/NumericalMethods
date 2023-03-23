
load P_ref.mat
N = 5:50:10^4;
n = 5;
fmax = func(10);

err_mp = [];
err_mt = [];
err_ms = [];
err_mc = [];

j = 1;
for k = N
   mp = 0; mt = 0; ms = 0; mc = 0;
   dx = n / k;
   N1 = 0;

   for i = 1:k
       xi = (i - 1) * dx;
       xi1 = i * dx;

       % metoda prostokatow
       mp = mp + func((xi + xi1) / 2) * dx;

       % metoda trapezow
       mt = mt + (func(xi) + func(xi1)) / 2 * dx;
       
       % metoda Simpsona
       ms = ms + (func(xi) + 4 * func((xi + xi1) / 2) + func(xi1));

       % metoda Monte Carlo
       x = rand() * n;
       y = rand() * fmax;
       if y < func(x)
           N1 = N1 + 1;
       end
   end

   ms = ms * dx / 6;
   mc = (N1 / k) * n * fmax;
   
   err_mp(j) = abs(mp - P_ref);
   err_mt(j) = abs(mt - P_ref);
   err_ms(j) = abs(ms - P_ref);
   err_mc(j) = abs(mc - P_ref);

   j = j + 1;
end

figure();
loglog(N, err_mp);
title('Błąd - metoda prostokątów');
xlabel('Liczba przedziałów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_metody_prostokatow.png')

figure();
loglog(N, err_mt);
title('Błąd - metoda trapezów');
xlabel('Liczba przedziałów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_metody_trapezow.png')

figure();
loglog(N, err_ms);
title('Błąd - metoda Simpsona');
xlabel('Liczba przedziałów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_metody_simpsona.png')

figure();
loglog(N, err_mc);
title('Błąd - metoda Monte Carlo');
xlabel('Liczba punktów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_metody_monte_carlo.png')


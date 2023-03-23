K = 6:45;
divp = ones(1, 40);
divt = ones(1, 40);

[XX, YY] = meshgrid(linspace(0, 100, 101), linspace(0, 100, 101));
[x, y, f, xp, yp] = lazik(5);
[p] = polyfit2d(x, y, f);
[FFp] = polyval2d(XX, YY, p);

[p] = trygfit2d(x, y, f);
[FFt] = trygval2d(XX, YY, p);

for k = K
    [x, y, f, xp, yp] = lazik(k);
    [p] = polyfit2d(x, y, f);
    [FF] = polyval2d(XX, YY, p);
    divp(k-5) = max(max(abs(FF-FFp)));
    FFp = FF;

    [p] = trygfit2d(x, y, f);
    [FF] = trygval2d(XX, YY, p);
    divt(k-5) = max(max(abs(FF-FFt)));
    FFt = FF;
end

figure();
plot(K, divp);
title('Zbieznosc - interpolacja wielomianowa');
xlabel('Liczba punktow pomiarowych k');
ylabel('Zbieznosc funkcji interpolowanej');
saveas(gcf, 'zad2_wiel.png')

figure();
plot(K, divt);
title('Zbieznosc - interpolacja trygonometryczna');
xlabel('Liczba punktow pomiarowych k');
ylabel('Zbieznosc funkcji interpolowanej');
saveas(gcf, 'zad2_tryg.png')


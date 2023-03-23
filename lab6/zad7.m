load trajektoria2

N = 60;

[ xa ] = aprox_tryg(n, x, N);
[ ya ] = aprox_tryg(n, y, N);
[ za ] = aprox_tryg(n, z, N);

plot3(x, y, z, 'o')
hold on
plot3(xa, ya, za, 'LineWidth', 4)

grid on
axis equal
title("Trajektoria bazująca na lokalizacji i aproksymowana (tryg.)")
xlabel("X")
ylabel("Y")
zlabel("Z")

saveas(gcf, "184440_Lydka_zad7.png")
hold off

M = length(n);
err = zeros(1, 71);
for N = 1:71
    [ xa ] = aprox_tryg(n, x, N);
    [ ya ] = aprox_tryg(n, y, N);
    [ za ] = aprox_tryg(n, z, N);

    err_x = sqrt(sum((x - xa).^2)) / M;
    err_y = sqrt(sum((y - ya).^2)) / M;
    err_z = sqrt(sum((z - za).^2)) / M;

    err(N) = err_x + err_y + err_z;
end

figure();
semilogy(err);
title("Wykres blędu aproksymacji");
xlabel("rząd aproksymacji N");
ylabel("Wartość błędu");
grid();
saveas(gcf, "184440_Lydka_zad7_b.png")

running = true;
N = 1;
eps = 10^-2;
while running
    [ xa ] = aprox_tryg(n, x, N);
    [ ya ] = aprox_tryg(n, y, N);
    [ za ] = aprox_tryg(n, z, N);

    err_x = sqrt(sum((x - xa).^2)) / M;
    err_y = sqrt(sum((y - ya).^2)) / M;
    err_z = sqrt(sum((z - za).^2)) / M;
    
    err = err_x + err_y + err_z;
    if err < eps
        break;
    end
    N = N + 1;
end

[ xa ] = aprox_tryg(n, x, N);
[ ya ] = aprox_tryg(n, y, N);
[ za ] = aprox_tryg(n, z, N);

figure()
plot3(x, y, z, 'o')
hold on
plot3(xa, ya, za, 'LineWidth', 4)

grid on
axis equal
title("Wykres trajektorii dla automatycznie znalezionego rzędu aproksymacji N")
xlabel("X")
ylabel("Y")
zlabel("Z")



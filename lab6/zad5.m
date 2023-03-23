load trajektoria2

N = 60;

[ wsp_x, xa ] = aproksymacjaWiel(n, x, N);
[ wsp_y, ya ] = aproksymacjaWiel(n, y, N);
[ wsp_z, za ] = aproksymacjaWiel(n, z, N);

plot3(x, y, z, 'o')
hold on
plot3(xa, ya, za, 'LineWidth', 4)

grid on
axis equal
title("Trajektoria bazująca na lokalizacji i aproksymowana (wiel.)")
xlabel("X")
ylabel("Y")
zlabel("Z")

saveas(gcf, "184440_Lydka_zad5.png")
hold off

M = length(n);
err = zeros(1, 71);
for N = 1:71
    [ wsp_x, xa ] = aproksymacjaWiel(n, x, N);
    [ wsp_y, ya ] = aproksymacjaWiel(n, y, N);
    [ wsp_z, za ] = aproksymacjaWiel(n, z, N);

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
saveas(gcf, "184440_Lydka_zad5_b.png")

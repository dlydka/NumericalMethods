load trajektoria1

N = 50;

[ wsp_x, xa ] = aproksymacjaWiel(n, x, N);
[ wsp_y, ya ] = aproksymacjaWiel(n, y, N);
[ wsp_z, za ] = aproksymacjaWiel(n, z, N);

plot3(x, y, z, 'o')
hold on
plot3(xa, ya, za, 'LineWidth', 4)

grid on
axis equal
title("Trajektoria bazująca na lokalizacji i aproksymowana dla N = 50")
xlabel("X")
ylabel("Y")
zlabel("Z")

saveas(gcf, "184440_Lydka_zad4.png")


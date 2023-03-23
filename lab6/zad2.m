load trajektoria1

plot3(x, y, z, 'o')
title("Zmierzona trajektoria drona")
xlabel("X")
ylabel("Y")
zlabel("Z")
grid on
axis equal


saveas(gcf, "184440_Lydka_zad2.png")
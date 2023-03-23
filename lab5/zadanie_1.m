K = [5, 15, 25, 35];

for i = K
    [XX, YY] = meshgrid(linspace(0, 100, 101), linspace(0, 100, 101));
    [x, y, f, xp, yp] = lazik(i);
    
    figure();
    subplot(2, 2, 1);
    plot(xp, yp, '-o', 'linewidth', 3);
    title(strcat('Tor ruchu lazika dla K = ', num2str(i)));
    xlabel('x [m]');
    ylabel('y [m]');
    grid on;
        
    subplot(2, 2, 2);
    plot3(x, y, f, 'o');
    title(strcat('Zebrane wartosci probekd dla K = ', num2str(i)));
    xlabel('x [m]');
    ylabel('y [m]');
    zlabel('f(x,y)');
    grid on;
        
    subplot(2, 2, 3);
    [p] = polyfit2d(x, y, f);
    [FF] = polyval2d(XX, YY, p);
    surf(XX, YY, FF);
    shading flat;
    title(strcat('Interpolacja wielomianowa dla K = ', num2str(i)));
    xlabel('x [m]');
    ylabel('y [m]');
    zlabel('f(x,y)');
    grid on;

    subplot(2, 2, 4);
    [p] = trygfit2d(x, y, f);
    [FF] = trygval2d(XX, YY, p);
    surf(XX, YY, FF);
    shading flat;
    title(strcat('Interpolacja trygonometrycznad dla K = ', num2str(i)));
    xlabel("x [m]");
    ylabel("y [m]");
    zlabel("f(x,y)");
    grid on;  
    
    saveas(gcf, strcat("zad1_K_", num2str(i), ".png"));
end

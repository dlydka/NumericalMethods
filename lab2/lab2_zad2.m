a = 10;
r_max = 3;
n_max = 200;
n = 0;
area = 0;
attmept = 0;
x = [];
y = [];
r = [];
areas = [];
attempts = [];

while n <= n_max
    fitsInSquare = false;
    crossed = false;
    while fitsInSquare == false
        attmept = attmept + 1;
        randomX = rand(1) * a;
        randomY = rand(1) * a;
        randomR = rand(1) * r_max;

        if (randomX+randomR < a && randomX-randomR > 0 && randomY+randomR < a && randomY-randomR > 0)
            fitsInSquare = true;
        end
    end
    
    if (fitsInSquare && n > 0)
        for i = 1:n
            deltaX = randomX - x(i);
            deltaY = randomY - y(i);

            if (sqrt(deltaX*deltaX + deltaY*deltaY) <= (randomR+r(i)))
                crossed = true;
                break;
            end
        end
    end

    if crossed == false
        n = n + 1;
        x(n) = randomX;
        y(n) = randomY;
        r(n) = randomR;

        area = area + pi * randomR^2;
        areas(n) = area;

        attempts(n) = attmept;
        attmept = 0;
        
        axis equal;
        plot_circ(randomX, randomY, randomR);
        hold on;
        fprintf(1, ' %s%5d%s%.3g\r ', 'n =',  n, ' S = ', area);
        pause(0.1);
    end
end

figure('Name','Historia powierzchni w funkcji n');
semilogx(1:n, areas);
title('Powierzchnia całkowita');
xlabel('n');
ylabel('Powierzchnia całkowita');
saveas(gcf, 'wykres1.png');

figure('Name','Historia średniej wartości losowań w funkcji n');
loglog(cumsum(attempts)./(1:n));
title('Średnia liczba losowań');
xlabel('n');
ylabel('Liczba losowań');
saveas(gcf, 'wykres2.png');

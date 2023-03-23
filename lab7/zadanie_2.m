N = 1e5;
max_x = 100;
max_y = 100;
min_z = -50;
V = max_x * max_y * (-1 * min_z);

N1 = 0;
for i = 1:N
    rand_x = rand() * max_x;
    rand_y = rand() * max_y;
    rand_z = rand() * min_z;
    z = glebokosc(rand_x, rand_y);
    if rand_z > z
        N1 = N1 + 1;
    end
end

V = N1 / N * V;

import csv
from matplotlib import pyplot
from calc_operations import *

POINTS = 17


def read_data():
    data = []
    with open('data/MountEverest.csv', 'r') as file:
        points = list(csv.reader(file))
        iterpolation_points = points[1::]
        for row in iterpolation_points:
            r = [float(row[0]), float(row[1])]
            data.append(r)

        return data


def get_points(points, interval):
    data = []
    for i in range(0, len(points), interval):
        row = [points[i][0], points[i][1]]
        data.append(row)

    row = [points[len(points) - 1][0], points[len(points) - 1][1]]
    data.append(row)

    return data


def pivoting(L, U, P, k):
    pivot = abs(U[k][k])
    ind = k

    for j in range(k + 1, len(U)):
        if abs(U[j][k] > pivot):
            pivot = abs(U[j][k])
            ind = j

    if ind != k:
        for j in range(len(U)):
            if j >= k:
                tmp = U[k][j]
                U[k][j] = U[ind][j]
                U[ind][j] = tmp
            else:
                tmp = L[k][j]
                L[k][j] = L[ind][j]
                L[ind][j] = tmp

            tmp = P[k][j]
            P[k][j] = P[ind][j]
            P[ind][j] = tmp

    return L, U, P


def lu_decomposition(A, b, n):
    L = create_identity_matrix(n)
    U = matrix_copy(A)
    P = create_identity_matrix(n)

    # rozbicie na macierze L i U
    for k in range(n - 1):
        L, U, P = pivoting(L, U, P, k)
        for j in range(k + 1, n):
            L[j][k] = U[j][k] / U[k][k]
            for i in range(k, n):
                U[j][i] = U[j][i] - L[j][k] * U[k][i]

    b = matrix_multiplicate_vec(P, b)

    # rozwiazanie ukladu rownan Ly = b za pomoca podstawiania wprzod
    y = vec_zeros(n)
    y[0] = b[0] / L[0][0]
    for i in range(1, n):
        s = 0
        for k in range(0, i):
            s += L[i][k] * y[k]
        y[i] = (b[i] - s) / L[i][i]

    # rozwiazanie ukladu rownan Ux = y za pomoca podstawiania wstecz
    x = vec_zeros(n)
    x[n - 1] = y[n - 1] / U[n - 1][n - 1]
    for i in range(1, n):
        j = n - 1 - i
        s = 0
        for k in range(0, i):
            s += U[j][n - 1 - k] * x[n - 1 - k]
        x[j] = (y[j] - s) / U[j][j]

    return x


def lagrange_interpolation(points, data, length):
    interpolated_points = []

    for k in range(length):
        F = 0
        for i in range(len(points)):
            f = 1
            xi = points[i][0]
            yi = points[i][1]
            for j in range(len(points)):
                xj = points[j][0]
                if i != j:
                    f *= (data[k][0] - xj)/(xi - xj)
            F += f * yi
        interpolated_points.append(F)

    return interpolated_points


def spline_interpolation(points, distance):
    n = len(points)
    A = create_zeros_matrix(4 * (n - 1))
    b = vec_zeros(4 * (n - 1))

    A[0][0] = 1
    b[0] = points[0][1]

    h = points[1][0] - points[0][0]
    A[1][0] = 1
    A[1][1] = h
    A[1][2] = pow(h, 2)
    A[1][3] = pow(h, 3)
    b[1] = points[1][1]

    A[2][2] = 2
    b[2] = 0

    h = points[n - 1][0] - points[n - 2][0]
    A[3][4 * (n - 2) + 2] = 2
    A[3][4 * (n - 2) + 3] = 6 * h
    b[3] = 0

    for i in range(1, n - 1):
        h = points[i][0] - points[i - 1][0]

        # Si(xi) = f(xi) -->  [ai * 1] = f(xi)
        A[4 * i][4 * i] = 1
        b[4 * i] = points[i][1]

        # Si(xi + 1) = f(x + 1) -->  [ai * 1] + [bi * h] + [ci * h ^ 2] + [di * h ^ 3] = f(xi + 1)
        A[4 * i + 1][4 * i] = 1
        A[4 * i + 1][4 * i + 1] = h
        A[4 * i + 1][4 * i + 2] = pow(h, 2)
        A[4 * i + 1][4 * i + 3] = pow(h, 3)
        b[4 * i + 1] = points[i + 1][1]

        # S'i-1(xi) = S'i(xi) -->  [bi - 1 * 1] + [ci - 1 * 2 * h] + [di - 1 * 3 * h ^ 2] = [bi] -->  [bi - 1 * 1]
        # + [ci - 1 * 2 * h] + [di - 1 * 3 * h ^ 2] + [bi * (-1)] = 0
        A[4 * i + 2][4 * (i - 1) + 1] = 1
        A[4 * i + 2][4 * (i - 1) + 2] = 2 * h
        A[4 * i + 2][4 * (i - 1) + 3] = 3 * pow(h, 2)
        A[4 * i + 2][4 * i + 1] = -1
        b[4 * i + 2] = 0

        # S''i - 1(xi) = S''i(xi) -->  [ci - 1 * 2] + [di - 1 * 6 * h] = [ci * 2] -->  [ci - 1 * 2] + [di - 1 * 6 * h]
        # + [ci * (-2)] = 0
        A[4 * i + 3][4 * (i - 1) + 2] = 2
        A[4 * i + 3][4 * (i - 1) + 3] = 6 * h
        A[4 * i + 3][4 * i + 2] = -2
        b[4 * i + 3] = 0

    x = lu_decomposition(A, b, 4 * (n - 1))

    elevation = 0
    for i in range(n - 1):
        elevation = 0
        if points[i][0] <= distance <= points[i + 1][0]:
            for j in range(4):
                h = distance - points[i][0]
                elevation += x[4 * i + j] * pow(h, j)
            break

    return elevation


def interpolate_with_splines(data, points):
    x = []
    y = []
    for i in range(len(data)):
        elevation = spline_interpolation(points, data[i][0])
        x.append(data[i][0])
        y.append(elevation)

    return x, y


if __name__ == "__main__":
    data = read_data()
    points = get_points(data, len(data) // (POINTS - 1))
    k = 0
    for i in range(len(data)):
        if data[i][0] <= points[len(points) - 1][0]:
            k += 1

    interpolated_points = lagrange_interpolation(points, data, k)
    x = []
    inter_x = []
    h = []
    x1 = []
    y = []
    for i in range(len(data)):
        x.append(data[i][0])
        h.append((data[i][1]))
        if i < k:
            inter_x.append(data[i][0])

    for i in range(len(points)):
        x1.append(points[i][0])
        y.append(points[i][1])


    #pyplot.plot(x, h, 'b', label='pełne dane')
    #pyplot.plot(inter_x, interpolated_points, 'r', label='wynik interpolacji')
    #pyplot.plot(x1, y, 'ro', label='dane do interpolacji')
    #pyplot.legend()
    #pyplot.ylabel('Wysokość')
    #pyplot.xlabel('Odległość')
    #pyplot.title('Interpolacja Lagrange\'a, dla ' + str(POINTS) + ' węzłów\nMountEverest.csv')
    #pyplot.grid()
    #pyplot.show()

    x11, y11 = interpolate_with_splines(data, points)
    pyplot.plot(x, h, 'b', label='pełne dane')
    pyplot.plot(x11, y11, 'r', label='wynik interpolacji')
    pyplot.plot(x1, y, 'ro', label='dane do interpolacji')
    pyplot.legend()
    pyplot.ylabel('Wysokość')
    pyplot.xlabel('Odległość')
    pyplot.title('Interpolacja funkcjami sklejanymi\'a, dla ' + str(POINTS) + ' węzłów\nMountEverest.csv')
    pyplot.grid()
    pyplot.show()

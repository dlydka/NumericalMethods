import time
from calc_functions import *


def jacobi(a, b):
    iterations = 0
    x_prev = vec_zeros(len(a))
    x = vec_zeros(len(a))

    d_time = time.time()
    while True:
        for i in range(len(a)):
            S = 0
            for j in range(len(a)):
                if j != i:
                    S += a[i][j] * x_prev[j]
            x[i] = (b[i] - S) / a[i][i]
        x_prev = vec_copy(x)
        res = calc_residuum(a, x_prev, b)
        if norm(res) < pow(10, -9):
            break
        iterations += 1

    print("Jacobi")
    print("Czas: ", time.time() - d_time)
    print("Iteraacje: ", iterations)
    return time.time() - d_time


def gauss_seidl(a, b):
    iterations = 0
    x = vec_zeros(len(a))

    d_time = time.time()
    while True:
        for i in range(len(a)):
            S = 0
            for j in range(len(a)):
                if j != i:
                    S += a[i][j] * x[j]
            x[i] = (b[i] - S) / a[i][i]
        res = calc_residuum(a, x, b)
        if norm(res) < pow(10, -9):
            break
        iterations += 1

    print("Gauss-Seidl")
    print("Czas: ", time.time() - d_time)
    print("Iteraacje: ", iterations)
    return time.time() - d_time


def lu_factorization(A, b):

    L = create_identity_matrix(len(A))
    U = matrix_copy(A)

    # rozbicie na macierze L i U
    d_time = time.time()
    n = len(A)
    for k in range(n - 1):
        for j in range(k + 1, n):
            L[j][k] = U[j][k] / U[k][k]
            for i in range(k, n):
                U[j][i] = U[j][i] - L[j][k] * U[k][i]

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

    res = calc_residuum(A, x, b)

    print("Faktoryzacja LU")
    print("Norma z residuum: ", norm(res))
    print("Czas: ", time.time() - d_time)
    return time.time() - d_time

from Matrix import *
from solving_methods import *
from matplotlib import pyplot

if __name__ == '__main__':
    # zad A
    mat = Matrix()
    matA = mat.create_matrix(mat.e + 5, -1, -1)
    b = mat.create_vector_b()

    # zad B
    print("Zad B:")
    jacobi(matA, b)
    gauss_seidl(matA, b)

    # zad C
    print("Zad C")
    matC = mat.create_matrix(3, -1, -1)
    # jacobi(matC, b)
    # gauss_seidl(matC, b)

    # zad D
    print("Zad D")
    lu_factorization(matC, b)

    # zad E
    N = [100, 500, 1000, 2000, 3000]
    jacobi_times = []
    gauss_times = []
    lu_times = []

    for n in N:
        print("N = ", n)
        mat.N = n
        matA = mat.create_matrix(mat.e + 5, -1, -1)
        b = mat.create_vector_b()

        time_jacobi = jacobi(matA, b)
        time_gauss = gauss_seidl(matA, b)
        time_lu = lu_factorization(matA, b)

        jacobi_times.append(time_jacobi)
        gauss_times.append(time_gauss)
        lu_times.append(time_lu)

    pyplot.plot(N, jacobi_times, label="Jacobi", color="red")
    pyplot.plot(N, gauss_times, label="Gauss-Seidl", color="blue")
    pyplot.plot(N, lu_times, label="LU", color="green")
    pyplot.legend()
    pyplot.grid(True)
    pyplot.ylabel('Czas (s)')
    pyplot.xlabel('Liczba niewiadomych')
    pyplot.title('Zależność czasu od liczby niewiadomych')
    pyplot.show()

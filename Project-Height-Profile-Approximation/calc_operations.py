def create_identity_matrix(length):
    mat = []
    for i in range(length):
        col = []
        for j in range(length):
            if j == i:
                col.append(1)
            else:
                col.append(0)
        mat.append(col)

    return mat


def create_zeros_matrix(length):
    mat = []
    for i in range(length):
        col = []
        for j in range(length):
            col.append(0)
        mat.append(col)

    return mat


def vec_copy(a):
    vec = []
    for i in range(len(a)):
        vec.append(a[i])

    return vec


def matrix_copy(A):
    mat = []
    for i in range(len(A)):
        col = []
        for j in range(len(A)):
            col.append(A[i][j])
        mat.append(col)

    return mat


def vec_zeros(length):
    vec = [0 for _ in range(length)]

    return vec


def matrix_multiplicate_vec(A, b):
    n = len(A)
    out = []
    for i in range(n):
        s = 0
        for j in range(n):
            s += A[i][j] * b[j]
        out.append(s)
    return out



def vec_sub(a, b):
    for i in range(len(a)):
        a[i] -= b[i]

    return a


def norm(a):
    norm = 0
    for i in range(len(a)):
        norm += pow(a[i], 2)
    norm = pow(norm, 0.5)
    return norm


def vec_zeros(length):
    vec = [0 for _ in range(length)]

    return vec


def calc_residuum(a, x, b):
    res = vec_zeros(len(a))

    for i in range(len(a)):
        for j in range(len(a)):
            res[i] += a[i][j] * x[j]

    res = vec_sub(res, b)

    return res


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

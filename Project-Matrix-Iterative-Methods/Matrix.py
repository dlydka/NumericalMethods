from math import sin


class Matrix:
    def __init__(self):
        self.index = [1, 8, 4, 4, 4, 0]
        self.c = self.index[4]
        self.d = self.index[5]
        self.e = self.index[3]
        self.f = self.index[2]
        self.N = 9 * 100 + self.c * 10 + self.d

    def create_matrix(self, a1, a2, a3):
        mat = []
        for i in range(self.N):
            col = []
            for j in range(self.N):
                if j == i:
                    col.append(a1)
                elif j == i + 1 or j == i - 1:
                    col.append(a2)
                elif j == i + 2 or j == i - 2:
                    col.append(a3)
                else:
                    col.append(0)
            mat.append(col)

        return mat

    def create_vector_b(self):
        b = []
        for n in range(self.N):
            b.append(sin(n * (self.f + 1)))

        return b

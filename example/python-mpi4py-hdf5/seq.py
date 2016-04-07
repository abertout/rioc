import h5py
import numpy as np

with h5py.File('input.h5') as f:
    A = f['matrix'].value
    b = f['vector'].value

nrows, ncols = A.shape

x = np.dot(A,b)

x_expected = np.empty( (nrows,) )

for i in range(nrows):
    t = 0
    for j in range(ncols):
        t += (j + i*ncols) * j
    x_expected[i] = t

print("A:")
print(A)
print()

print("b:")
print(b)
print()

print("x:")
print(x)
print()

print("x_expected:")
print(x_expected)
print()

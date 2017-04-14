using DijkstraIndexing
using Base.Test

# Scoping.
A = range(0, 3);
@dsindex b = A[0];
@test b == 0
A = range(1, 3);
@dsindex b = A[0];
@test b == 1

# `end` usage.
@dsindex b = A[end - 1];
@test b == 3

# Colon indexing.
@dsindex c = A[0:end];
@test c == range(1, 3);
@dsindex c = A[1:end];
@test c == range(2, 2);
@dsindex c = A[1:end-1];
@test c == range(2, 1);
# Step size.
B = range(0, 9);
@dsindex d = B[0:2:end];
@test d == 0:2:8;
@dsindex d = B[1:2:end];
@test d == 1:2:7;

# Indirect reference.
@dsindex e = A[B[0 * 2] + 1];
@assert e == 2;

# ND.
C = zeros((3, 3));
@dsindex f = C[0, 0];
@assert f == 0

# Colon selection.
@dsindex g = C[0, :];
@assert g == [0, 0, 0]

# Colon usage.
@dsindex h = 0:3;
@assert h == 0:2

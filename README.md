# DijkstraIndexing

[![Build Status](https://travis-ci.org/classner/DijkstraIndexing.jl.svg?branch=master)](https://travis-ci.org/classner/DijkstraIndexing.jl)

[![Coverage Status](https://coveralls.io/repos/classner/DijkstraIndexing.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/classner/DijkstraIndexing.jl?branch=master)

[![codecov.io](http://codecov.io/github/classner/DijkstraIndexing.jl/coverage.svg?branch=master)](http://codecov.io/github/classner/DijkstraIndexing.jl?branch=master)

Julia made the choice to use a 1-based indexing scheme with closed intervals.
This makes the move from MATLAB to Julia easier. For some algorithms and for
porting code from other languages, e.g. Python, it may make sense to on-demand
switch to a 0-based indexing scheme. This package provides a macro to provide
this functionality in a hassle-free and explicit way. Renowned computer
scientist Edsger W. Dijkstra wrote a short article about the indexing schemes
arguing for a 0-based half-open one
(see
[here](http://www.cs.utexas.edu/users/EWD/transcriptions/EWD08xx/EWD831.html)
and for more information about the
topic [here](https://en.wikipedia.org/wiki/Zero-based_numbering)), that's where
the package name comes from.

## Usage

The module only exposes the macro `@dsindex`. It can be used on an environment
or single expression and always works with the local variables:

```
A = range(0, 3);
@dsindex b = A[0];
@assert b == 0

# Use it on sections of code and with arbitrary nested or range expressions.
B = range(1, 2);
@dsindex begin
  c = A[B[0+1]-1];
  d = B[1:end];
end
@assert c == 1
@assert d == 2
```

Slicing expressions are exclusive in the macro and `end` refers to the position
after the last array element, making the notation concise. That means, that
`A[end]` will throw an exception and the last sequence element is accessed with
`A[end-1]` (this is consistent with, e.g., Python access for A[-1]).

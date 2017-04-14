# DijkstraIndexing

Julia made the choice to use a 1-based indexing scheme with closed intervals.
This makes the move from MATLAB to Julia easier. For some algorithms and for
porting code from other languages, e.g. Python, it may make sense to on-demand
switch to a 0-based indexing scheme with half-open intervals. This package
provides a macro to provide this functionality in a hassle-free and explicit
way. Renowned computer scientist Edsger W. Dijkstra wrote a short article
arguing for this indexing scheme
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

# Use it on sections of code and with arbitrary nested or slice expressions.
B = range(1, 2);
@dsindex begin
  c = A[B[0+1]-1];
  d = B[1:end];
end
@assert c == 1
@assert d == 2

# ND-Arrays.
C = zeros((3, 3))
@dsindex e = C[0, 0];
@assert e == 0
```

Slicing expressions are half-open intervals, including start and excluding the
end. Steps are supported. `end` refers to the position after the last array
element, making the notation concise. That means, that `A[end]` will throw an
exception and the last sequence element is accessed with `A[end-1]` (this is
consistent with, e.g., Python access for A[-1]).

### Why not custom-index arrays?

See [here](https://github.com/JuliaLang/julia/pull/16260). If you can
create your own objects and use them in your own library, this may be the best
solution. If you receive objects to index from another library, however, and do
not want to wrap them or pass them on to a library that doesn't support these
general iterators (yet), problems may arise.

### Is there a performance overhead?

Since the macro is executed at compile time to rewrite the code, there's no
runtime overhead.

## Credits

This code is based on a [gist](https://gist.github.com/albop/7525675) by Pablo
Winant.

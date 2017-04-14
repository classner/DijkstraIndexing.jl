module DijkstraIndexing

export @dsindex

rewrite(x::Number) = x;
rewrite(x::Symbol) = x;
rewrite(x::String) = x;
function rewrite(expr)
    if expr.head == :ref
        return Expr(expr.head, expr.args[1],
                    [rewrite(:(1 + $arg)) for arg in expr.args[2:end]]...)
    elseif expr.head == :(:)
        argl = [rewrite(:(0+$(expr.args[1])))];
        if length(expr.args) == 3
            # Step size.
            push!(argl, rewrite(:(0+$(expr.args[2]))));
        end
        push!(argl, rewrite(:($(expr.args[end])-1)));
        return Expr(expr.head, argl...);
    else
        return Expr(expr.head, [rewrite(i) for i in expr.args]...)
    end
end

macro dsindex(expr)
    return esc(rewrite(expr))
end

end # module

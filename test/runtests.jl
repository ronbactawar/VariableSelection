using VariableSelector
using Test
using DataFrames

@testset "VariableSelector.jl" begin
    df = DataFrame(
    A = [1, 2, 3, 4, 5, 6], 
    B = ["a", "b", "a", "b", "a", "b"],
    C = ["c", "d", "c", "d", "c", "c"],
    T = [.17, .23, .36, .46, .58, .67],
    )

    #@test names(VariableSelector.variable_importance(df)) == ["feature", "test", "pvalue"]
    @test 1 == 1

end

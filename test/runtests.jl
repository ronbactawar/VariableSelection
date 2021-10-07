using VariableSelector
using Test
using DataFrames

@testset "VariableSelector.jl" begin

    
    con1 = [1, 2, 3, 4, 5, 6,7 ,8, 9, 10] 
    con2 = [.17, .23, .36, .46, .58, .67, .77, .84, .92, 1.2]
    cat1 = ["a", "b", "a", "b", "a", "b", "a", "c", "b", "a"]
    cat2 = ["c", "d", "c", "d", "c", "c", "b", "c", "c", "c"]
    

    #@test names(VariableSelector.variable_importance(df)) == ["feature", "test", "pvalue"]
    @test VariableSelector.gamma(con1, con2)[1] <= 1
    @test VariableSelector.gamma(cat1, cat2)[1] <= 1

end

 
using DataFrames
using Statistics
using StatsBase
using HypothesisTests


# Function for cat/con
# The test for such combo is "KruskalWallis"
function gamma(cat_var::Vector{String}, con_var::Vector{<: Number})
    data = DataFrame(levels = cat_var, values = con_var)
    levels = data.levels |> Set |> collect
    vec_list = Vector{Float64}[]
    for i in levels
      filtered_df = data[data.levels .== i, :]
      filtered_vec = filtered_df.values
      push!(vec_list, filtered_vec)  
    end
    p = KruskalWallisTest(vec_list...) |> pvalue  
    p = round(p, digits  = 3)
    return (p, "KruskalWallis")
  end
  
  # Function for con/cat
  # The test for such combo is "KruskalWallis"
  function gamma(con_var::Vector{<: Number}, cat_var::Vector{String})
    gamma(cat_var, con_var)
  end
  
  # Function for cat/cat
  # The test for such combo is "ChiSquared"
  function gamma(cat_var1::Vector{String}, cat_var2::Vector{String})
    data = DataFrame(levels1 = cat_var1, levels2 = cat_var2)
    ul1 = data.levels1 |> Set |> collect |> sort
    ul2 = data.levels2 |> Set |> collect |> sort
    output = zeros(Int64, length(ul1), length(ul2))
    for i in eachindex(ul1), j in eachindex(ul2)
      tv = (data.levels1 .== ul1[i]) .& (data.levels2 .== ul2[j])
      output[i,j] = sum(tv)  
    end
    p = ChisqTest(output) |> pvalue
    return (p, "ChiSquared")
  end
  
  
  # Function for con/con
  function gamma(con_var1::Vector{<: Number}, con_var2::Vector{<: Number})
    th = 20 # Treshold for if vector should be category or not
    
    # Get the # of levels for each vector
    l1 = con_var1 |> Set |> length
    l2 = con_var2 |> Set |> length
    
    # Get the string vector of each vector
    con_var1_st = string.(con_var1)
    con_var2_st = string.(con_var2)
    
    # Treat vectors with low number of levels as categories and apply the right test
    if l1 <= th && l2 <= th
      gamma(con_var1_st, con_var1_st) # Apply ChiSquared test
    elseif l1 <= th && l2 > th
      gamma(con_var1_st, con_var2)  # Apply "KruskalWallis" test
    elseif l1 > th && l2 <= th
      gamma(con_var1, con_var2_st) # Apply "KruskalWallis" test
    else
      p = CorrelationTest(con_var1, con_var2) |> pvalue # Apply "Correlation" test
      return (p, "Correlation")
    end
  end
  
  # Finds the most important variables against the target
  function variable_importance(data::DataFrame, target::Symbol)
    X = select(data, Not(target)) # Get DataFrame X of x variables
    y = data[!, target] # Obtain y vector
    col_names = names(X) # Name vector of X dataframe
    output = DataFrame(feature = String[], test = String[], pvalue = Float64[])
    for i in col_names
      x = X[!, i]
      J = gamma(x, y)
      push!(output, [i, J[2], J[1]])
    end
    tv = (output.pvalue .< 0.05)
    results = output[tv, :]
    return results
  end

println("test")
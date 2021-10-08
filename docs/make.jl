using VariableSelector
using Documenter

DocMeta.setdocmeta!(VariableSelector, :DocTestSetup, :(using VariableSelector); recursive=true)

makedocs(;
    modules=[VariableSelector],
    authors="rbac <ronbactawar@gmail.com> and contributors",
    repo="https://github.com/rbac/VariableSelector.jl/blob/{commit}{path}#{line}",
    sitename="VariableSelector.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://rbac.github.io/VariableSelector.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/rbac/VariableSelector.jl",
)

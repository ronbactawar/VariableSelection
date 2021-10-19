# VariableSelector

## Description 
For each combination of a dependent variable and a target feature a statistical test is performed to test how the dependent effects the target.  Combinations of the dependent/target data types and the resulting tests performed are shown below.  Additionally,  if a numerical feature has a low enough carnality then it is automatically treated as categorical

| Dependent Feature  | Target Feature | Test Type     |
|--------------------|----------------|---------------|
| categorical        | categorical    | ChiSquared    |
| continuous         | continuous     | Correlation   |
| categorical        | continuous     | KruskalWallis |
| continuous         | categorical    | KruskalWallis |

## Usage
Suppose that a datafarame called **titanic** is stored and the target variable is **:survived**



using VariableSelector
VariableSelector.variable_importance(titanic, :Survived)

```julia
## use VariableSelector module
using VariableSelector

## Calling the variable_importance function
VariableSelector.variable_importance(titanic, :Survived)
```

## Output
The output produced is a dataframe with the **feature**,  **test** and **pvalue**.  Here is a description of the columns:

**feature:** the dependent variable that was tested against the target

**test:** The statistical test used which ares shown in the above table

**pvalue:**  This is the pvalue of the test, with pvalue < 0.05 being significant 
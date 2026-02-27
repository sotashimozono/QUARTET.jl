module LatBench

export AbstractModel, Model
export BoundaryCondition, Infinite, PBC, OBC
export AbstractQuantity, Quantity
export fetch

# --- Core Implementation ---
include("core/alias.jl")
include("core/type.jl")

# --- Universality Classes ---
include("universalities/E8.jl")

# --- Models ---
include("models/TFIM.jl")

end # module LatBench

module QUARTET

export AbstractModel, Model
export BoundaryCondition, Infinite, PBC, OBC
export AbstractQuantity, Quantity
export fetch

# --- Core Implementation ---
include("core/alias.jl")
include("core/type.jl")

# --- Universality Classes ---
include("universality/E8.jl")

# --- Models ---
include("model/TFIM.jl")

end # module QUARTET

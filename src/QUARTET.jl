module QUARTET

export AbstractModel, Model
export BoundaryCondition, Infinite, PBC, OBC
export AbstractQuantity, Quantity
export fetch

include("core/alias.jl")
include("core/type.jl")

include("universality/E8.jl")

end # module QUARTET

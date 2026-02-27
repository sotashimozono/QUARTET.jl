
"""
    AbstractModel
Struct for defining the model.
It should contain all the necessary information to construct the Hamiltonian and perform calculations,
such as the lattice geometry, interaction parameters, and any other relevant details.
"""
abstract type AbstractModel end

struct Model{M} <: AbstractModel
    params::Dict{Symbol,Any}
end
Model(name::Symbol; kwargs...) = Model{name}(Dict{Symbol,Any}(kwargs))

"""
    AbstractBoundaryCondition
Struct for defining the boundary conditions of the system. Available options include:
- `Infinite`: Infinite system with no boundaries.
- `PBC`: periodic boundary conditions
- `OBC`: open boundary conditions
"""
abstract type BoundaryCondition end
struct Infinite <: BoundaryCondition end
struct PBC <: BoundaryCondition end
struct OBC <: BoundaryCondition end

"""
    AbstractQuantity
"""
abstract type AbstractQuantity end

struct Quantity{Q} <: AbstractQuantity end
Quantity(q::Symbol) = Quantity{q}()
Quantity(q::String) = Quantity(Symbol(q))

"""
    function fetch(model::AbstractModel, quantity::AbstractQuantity; kwargs...)
Fetch the value of a quantity for a given model and boundary condition.
each implementation of `fetch` should be specific to the model and quantity being calculated, and may require additional parameters passed through `kwargs`.
"""
function fetch(m::Symbol, q::Symbol, bc::BoundaryCondition=Infinite(); kwargs...)
    return fetch(Model(m; kwargs...), Quantity(q), bc)
end
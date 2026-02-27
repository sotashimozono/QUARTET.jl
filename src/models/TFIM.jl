# ---
# Transverse Field Ising Model
# H = -J * sum(σ^z_i * σ^z_{i+1}) - h * sum(σ^x_i)
# ---

function fetch(
    model::Model{:TFIM}, quantity::Quantity{:energy}, bc::BoundaryCondition; J=1.0, h=1.0
)
    # Placeholder for actual energy calculation
    return -J - h
end

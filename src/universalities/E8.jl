"""
    E8_MASS_RATIOS
Analytical expressions for the 8 particle masses in the E8 spectrum of the Ising field theory. Normalized by the lightest mass m₁.

### References
- Theory: Zamolodchikov, A. B. (1989). Integrals of motion and S-matrix of the (scaled) T= Tc Ising model with magnetic field. *International Journal of Modern Physics A*, 4(16), 4235-4248.
- Review: Delfino, G. (2004). Integrable field theory and critical phenomena: the Ising model in a magnetic field. *Journal of Physics A: Mathematical and General*, 37(14), R45-R78.
- Experiment: Coldea, R., Tennant, D. A., Wheeler, E. M., Wawrzynska, E., Prabhakaran, D., Telling, M., ... & Kiefer, K. (2010). Quantum criticality in an Ising chain: experimental evidence for emergent E8 symmetry. *Science*, 327(5962), 177-180.
"""
function get_e8_mass_ratios()
    # Golden ratio ϕ = 2 cos(π/5) ≈ 1.618...
    # m₂/m₁ = ϕ is the hallmark of the E8 symmetry.
    ϕ = 2 * cos(π / 5)

    m1 = 1.0
    m2 = ϕ
    m3 = 2 * cos(π / 30)
    m4 = 2 * m2 * cos(7π / 30)
    m5 = 2 * m2 * cos(2π / 15)
    m6 = 2 * m2 * cos(π / 30)
    m7 = 4 * m2^2 * cos(7π / 30)
    m8 = 4 * m2^2 * cos(2π / 15)

    return [m1, m2, m3, m4, m5, m6, m7, m8]
end

# --- Registry & Fetch ---

@register_aliases canonicalize_quantity :E8_spectrum [
    :E8_mass_ratios, :E8_masses, :mass_ratios, :E8_mass_ratio, :mass_ratio
]

"""
    fetch(Model(:E8), Quantity(:E8_spectrum), Infinite())
Returns the analytical E8 mass spectrum.
"""
function QAtlas.fetch(::Model{:E8}, ::Quantity{:E8_spectrum}, ::Infinite; kwargs...)
    return get_e8_mass_ratios()
end

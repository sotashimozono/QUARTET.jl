
@testset "E8 Spectrum Logic" begin
    # 1. 基本的な構造のテスト
    @testset "Structure" begin
        masses = QAtlas.fetch(:E8, :E8_spectrum)
        @test length(masses) == 8
        @test masses[1] == 1.0
        @test all(masses .> 0)
        @test issorted(masses) # 質量は昇順であるべき
    end

    # 2. m₂/m₁ = golden ratio
    @testset "Golden Ratio Relationship" begin
        masses = QAtlas.fetch(:E8, :E8_spectrum)
        ϕ = (1 + sqrt(5)) / 2
        @test masses[2] ≈ ϕ atol = 1e-15
    end

    # 3. alias
    @testset "Aliases" begin
        expected = QAtlas.fetch(:E8, :E8_spectrum)

        @test QAtlas.fetch(:E8, :mass_ratios) == expected
        @test QAtlas.fetch(:E8, :E8_masses) == expected
        @test QAtlas.fetch(:E8, :mass_ratio) == expected
    end

    @testset "Type Stability" begin
        @test @inferred(QAtlas.fetch(Model(:E8), Quantity(:E8_spectrum), Infinite())) isa
            Vector{Float64}
    end
end

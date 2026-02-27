using Test

@testset "QUARTET.jl Alias Logic Tests" begin
    @testset "Model Alias Normalization" begin
        canon = :TFIM
        aliases = [:TransverseFieldIsingModel, :transverseFieldIsingModel]

        for al in aliases
            @test QUARTET.canonicalize_model(Val(al)) === canon
        end

        # canonical name should also resolve to itself
        @test QUARTET.canonicalize_model(Val(canon)) === canon

        # test for unknown model: should return the input as-is (no aliasing)
        @test QUARTET.canonicalize_model(Val(:ThisIsDefinitelyNotAModel)) ===
            :ThisIsDefinitelyNotAModel
        @test QUARTET.canonicalize_model(Val(:Supercalifragilistic)) ===
            :Supercalifragilistic
    end
    @testset "Quantity Alias Normalization" begin
        q_test_cases = [
            :energy => [:E, :Energy, :e],
            :entanglement_entropy => [:ee, :EE, :S_vN, :EntanglementEntropy],
            :central_charge => [:c, :cc, :CentralCharge],
            :zz_corr => [:ZZ, :zzcorr, :szsz],
        ]

        for (canon, aliases) in q_test_cases
            for al in aliases
                @test QUARTET.canonicalize_quantity(Val(al)) === canon
            end
            @test QUARTET.canonicalize_quantity(Val(canon)) === canon
        end

        @test QUARTET.canonicalize_quantity(Val(:magnetization)) === :magnetization
    end

    @testset "Integration via Constructors" begin
        m = QUARTET.Model(:TransverseFieldIsingModel; h=1.0)
        @test m isa QUARTET.Model{:TFIM}

        q = QUARTET.Quantity("S_vN")
        @test q isa QUARTET.Quantity{:entanglement_entropy}
    end
end
using Test

@testset "LatBench.jl Core Architecture Tests" begin
    # --- 1. test of multiple dispatch ---
    function LatBench.fetch(
        m::LatBench.Model{:Dummy}, ::LatBench.Quantity{:Answer}, ::LatBench.Infinite
    )
        return 42
    end
    function LatBench.fetch(
        m::LatBench.Model{:Dummy}, ::LatBench.Quantity{:ParamCheck}, ::LatBench.Infinite
    )
        return m.params[:val] * 2
    end
    function LatBench.fetch(
        ::LatBench.Model{:Dummy}, ::LatBench.Quantity{:Answer}, ::LatBench.OBC
    )
        return "Open Boundary"
    end

    # --- 2. verify definitions ---

    @testset "Construction & Parameters" begin
        m = LatBench.Model(:Dummy; a=1, b="hello")
        @test m isa LatBench.Model{:Dummy}
        @test m.params[:a] == 1
        @test m.params[:b] == "hello"

        q = LatBench.Quantity(:Test)
        @test q isa LatBench.Quantity{:Test}
    end

    @testset "Dispatch Logic (Core API)" begin
        # fetch(:Dummy, :Answer) -> fetch(Model(:Dummy), Quantity(:Answer), Infinite())
        @test LatBench.fetch(:Dummy, :Answer) == 42
        @test LatBench.fetch(:Dummy, :Answer, LatBench.Infinite()) == 42

        # dispatch of bounary conditions
        @test LatBench.fetch(:Dummy, :Answer, LatBench.OBC()) == "Open Boundary"
    end

    @testset "Keyword Argument Passing" begin
        # fetch(:Dummy, :ParamCheck; val=10) 
        # -> Model(:Dummy, val=10) が作られ、params[:val] が参照されるか
        @test LatBench.fetch(:Dummy, :ParamCheck; val=10) == 20
        @test LatBench.fetch(:Dummy, :ParamCheck; val=100) == 200
    end

    @testset "Error Handling (Strictness)" begin
        # if no method matches, it should throw a MethodError, not a generic error
        @test_throws ErrorException LatBench.fetch(:Dummy, :NotExist)
        # if model or quantity is unknown, it should also throw a MethodError
        @test_throws ErrorException LatBench.fetch(:UnknownModel, :Answer)
    end
    #=
    @testset "Type Stability" begin
        @test @inferred(LatBench.fetch(:Dummy, :Answer)) == 42
    end
    =#
end

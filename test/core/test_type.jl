using Test

@testset "QUARTET.jl Core Architecture Tests" begin
    # --- 1. test of multiple dispatch ---
    function QUARTET.fetch(
        m::QUARTET.Model{:Dummy}, ::QUARTET.Quantity{:Answer}, ::QUARTET.Infinite
    )
        return 42
    end
    function QUARTET.fetch(
        m::QUARTET.Model{:Dummy}, ::QUARTET.Quantity{:ParamCheck}, ::QUARTET.Infinite
    )
        return m.params[:val] * 2
    end
    function QUARTET.fetch(
        ::QUARTET.Model{:Dummy}, ::QUARTET.Quantity{:Answer}, ::QUARTET.OBC
    )
        return "Open Boundary"
    end

    # --- 2. verify definitions ---

    @testset "Construction & Parameters" begin
        m = QUARTET.Model(:Dummy; a=1, b="hello")
        @test m isa QUARTET.Model{:Dummy}
        @test m.params[:a] == 1
        @test m.params[:b] == "hello"

        q = QUARTET.Quantity(:Test)
        @test q isa QUARTET.Quantity{:Test}
    end

    @testset "Dispatch Logic (Core API)" begin
        # fetch(:Dummy, :Answer) -> fetch(Model(:Dummy), Quantity(:Answer), Infinite())
        @test QUARTET.fetch(:Dummy, :Answer) == 42
        @test QUARTET.fetch(:Dummy, :Answer, QUARTET.Infinite()) == 42

        # dispatch of bounary conditions
        @test QUARTET.fetch(:Dummy, :Answer, QUARTET.OBC()) == "Open Boundary"
    end

    @testset "Keyword Argument Passing" begin
        # fetch(:Dummy, :ParamCheck; val=10) 
        # -> Model(:Dummy, val=10) が作られ、params[:val] が参照されるか
        @test QUARTET.fetch(:Dummy, :ParamCheck; val=10) == 20
        @test QUARTET.fetch(:Dummy, :ParamCheck; val=100) == 200
    end

    @testset "Error Handling (Strictness)" begin
        # if no method matches, it should throw a MethodError, not a generic error
        @test_throws ErrorException QUARTET.fetch(:Dummy, :NotExist)
        # if model or quantity is unknown, it should also throw a MethodError
        @test_throws ErrorException QUARTET.fetch(:UnknownModel, :Answer)
    end
    #=
    @testset "Type Stability" begin
        @test @inferred(QUARTET.fetch(:Dummy, :Answer)) == 42
    end
    =#
end
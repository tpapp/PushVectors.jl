using PushVectors, Test, BenchmarkTools

@testset "implementation sanity checks" begin

    # create
    v = PushVector{Int}()
    @test v.len == 0
    @test v.parent isa Vector{Int}
    @test v == Int[]

    # add one element
    push!(v, 1)
    @test @inferred(v[1]) == 1
    @test v.len == 1 == length(v)
    @test size(v) == (1, )
    @test v == Int[1]

    # empty
    @test empty!(v) == Int[] == v

    # make it double
    for i in 1:5
        push!(v, i)
    end
    @test v == 1:5
    @test v.len == 5 == length(v)
    @test size(v) == (5, )
    @test length(v.parent) > 4
    @test @inferred setindex!(v, 9, 3) == 9
    w = [1, 2, 9, 4, 5]

    # sizehint!
    sizehint!(v, 20)            # up
    @test length(v.parent) == 20
    @test v == w

    sizehint!(v, 10)            # down
    @test v == w
    @test length(v.parent) == 10

    sizehint!(v, 3)             # ignored
    @test v == w
    @test length(v.parent) == 10

    @test @inferred(finish!(v)) == w
end

function pushit(v)
    for i in 1:10^4
        push!(v, i)
    end
end

@testset "relative benchmarking" begin
    T_PushVector = @belapsed begin
        p = PushVector{Int64}()
        pushit(p)
        finish!(p)
    end

    T_Vector = @belapsed begin
        p = Vector{Int64}()
        pushit(p)
    end

    @info "benchmarks" T_PushVector T_Vector
    @test T_PushVector ≤ T_Vector
end

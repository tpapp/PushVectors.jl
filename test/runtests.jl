using PushVectors, Test, BenchmarkTools

@testset "implementation sanity checks" begin
    v = PushVector{Int}()
    @test v.len == 0
    @test v.parent isa Vector{Int}
    @test v == Int[]
    push!(v, 1)
    @test @inferred(v[1]) == 1
    @test v.len == 1
    @test v == Int[1]

    # make it double
    for i in 2:5
        push!(v, i)
    end
    @test v == 1:5
    @test v.len == 5
    @test length(v.parent) > 4
    @test @inferred setindex!(v, 9, 3) == 9

    @test @inferred(finish!(v)) == [1, 2, 9, 4, 5]
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

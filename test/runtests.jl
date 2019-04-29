using PushVectors, Test

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

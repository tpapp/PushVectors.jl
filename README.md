# PushVectors

![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)<!--
![Lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-retired-orange.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-archived-red.svg)
![Lifecycle](https://img.shields.io/badge/lifecycle-dormant-blue.svg) -->
[![Build Status](https://travis-ci.com/tpapp/PushVectors.jl.svg?branch=master)](https://travis-ci.com/tpapp/PushVectors.jl)
[![codecov.io](http://codecov.io/github/tpapp/PushVectors.jl/coverage.svg?branch=master)](http://codecov.io/github/tpapp/PushVectors.jl?branch=master)

Implement a workaround for [julia#24909](https://github.com/JuliaLang/julia/issues/24909), using a [suggestion](https://github.com/JuliaLang/julia/issues/24909#issuecomment-419731925) by @KristofferC (code used with permission, modified by @tpapp, who is responsible for all bugs etc).

## Should I use this package?

Probably not, unless `push!` to `Vector` is **the** bottleneck in your code.

This is just a demonstration, and will be deprecated when the issue above is fixed.

## Overview

The single exported type is `PushVector`, which can be `push!`ed to. Use `finish!` to shrink and obtain the final vector, but note that you should not use the original after that.

```julia
julia> v = PushVector{Int}()
0-element PushVector{Int64,Array{Int64,1}}

julia> push!(v, 1)
1-element PushVector{Int64,Array{Int64,1}}:
 1

julia> finish!(v)
1-element Array{Int64,1}:
 1
```

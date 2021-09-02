#using Distributions
using Printf

L = 10.0
l = L / 2

@inline function enforce_bounds!(xs::Array{Float64, 1})
    for i in 1:length(xs)
        if xs[i] > l
            xs[i] = l
        elseif xs[i] < -l
            xs[i] = -l
        end
    end
end

function box_muller(alpha::Float64)::Array{Float64, 1}
    r1 = rand()
    r2 = rand()
    ys = alpha * [sqrt(-2 * log(r1 * sign(r1))) * cos(r2),
                  sqrt(-2 * log(r1 * sign(r1))) * sin(r2)]

    return ys
end

function npc_simulation(D::Float64; ntmax::Float64=1e6, dt::Float64=0.001,
                        n_samples::Int64=2000)::Array{Float64, 1}

    time_capture = Array{Float64, 1}(undef, n_samples)

    alpha = sqrt(2 * D * dt)
    #move_distr = Normal(0.0, alpha)

    NPCLocation = [-l, 0]
    NPCSize = 0.01
    NPCSize_sqr = NPCSize ^ 2

    @time begin
    for sample_num in 1:n_samples
        xs = [l, 0]

        for i in 1:ntmax
            #xs += vec(rand(move_distr, (2, 1)))
            xs += [randn(), randn()]

            for i in 1:length(xs)
                if xs[i] > l
                    xs[i] = l
                elseif xs[i] < -l
                    xs[i] = -l
                end
            end

            #enforce_bounds!(xs)
            #idx_to_change = abs.(xs) .> l
            #xs[idx_to_change] .= sign.(xs[idx_to_change]) .* l

            if (sum((xs .- NPCLocation) .^ 2) < NPCSize_sqr)
                time_capture[sample_num] = dt * i
            end
        end
    end
    end

    return time_capture
end

tcs = npc_simulation(10.0)

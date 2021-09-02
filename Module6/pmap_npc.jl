using Distributed
using Printf
@everywhere using Distributions

@everywhere L = 10.0

@everywhere @inline function enforce_bounds!(xs::Array{Float64, 1})
    for i in 1:length(xs)
        if xs[i] > L / 2
            xs[i] = L / 2
        elseif xs[i] < -L / 2
            xs[i] = -L / 2
        end
    end
end

function npc_simulation(D::Float64; ntmax::Float64=1e6, dt::Float64=0.001,
                        n_samples::Int64=2000)::Array{Float64, 1}

    @everywhere time_capture = Array{Float64, 1}(undef, n_samples)

    alpha = sqrt(2 * D * dt)
    @everywhere move_distr = Normal(0.0, alpha)

    @everywhere NPCLocation = [-L / 2, 0]
    @everywhere NPCSize = 0.01
    @everywhere NPCSize_sqr = NPCSize ^ 2

    @everywhere function run_sample(sample_num)
        t = 0.0
        xs = [L / 2, 0]

        for i in 1:ntmax
            xs += vec(rand(move_distr, (2, 1)))

            enforce_bounds!(xs)

            if (sum((xs .- NPCLocation) .^ 2) < NPCSize_sqr)
                time_capture[sample_num] = t
            end

            t += dt
        end
    end

    sample_nums = collect(1:n_samples)

    pmap(run_sample, sample_nums)

    return time_captures
end

@time npc_simulation(10.0)

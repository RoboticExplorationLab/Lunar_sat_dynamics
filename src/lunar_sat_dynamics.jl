using SatelliteDynamics
using DelimitedFiles
using LinearAlgebra
using Plots
using Pkg
Pkg.activate(".")
Pkg.instantiate()

coef = SatelliteDynamics.load_gravity_model_file("../lunar_gravity_models/lunar_grav.gfc")
n,m = 60,60

function lunar_orbit_dynamics(x)
    r = x[1:3]
    v = x[4:6]
    a = SatelliteDynamics.spherical_harmonic_gravity(r, GRAVITY_MODEL.data, n, m, GRAVITY_MODEL.R, 4.9048695e12)
    return [v; a]
end

function rkstep(x,Δt)
    k1 = Δt*lunar_orbit_dynamics(x)
    k2 = Δt*lunar_orbit_dynamics( x+k1/2)
    k3 = Δt*lunar_orbit_dynamics( x+k2/2)
    k4 = Δt*lunar_orbit_dynamics(x+k3)
    return x + (k1 + 2k2 + 2k3 + k4)/6
end

function run_sim(x0,Δt,t_end)
    t = 0.0
    x = x0
    x_hist = zeros(6,Int(t_end/Δt)+1)
    x_hist[:,1] .= x0
    i = 2
    while t < t_end
        x = rkstep(x,Δt)
        x_hist[:,i] .= x
        t += Δt
        i += 1
    end
    return x_hist
end
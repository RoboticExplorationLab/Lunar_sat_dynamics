# Lunar_sat_dynamics
Implementation of the dynamics of a satellite orbiting the Moon using SatelliteDynamics.jl as a backend. Includes multiple lunar gravity field models and some numerical simulations as examples
To run a simulation, just use: 

_run_sim(x0, Δt, tf)_ 

where x0 is the initial condition in the form [r0; v0] with r0 and v0 being an inertial frame 3D position and velocity vector Δt is the time step for numerical integration and tf the desired duration of the simulation

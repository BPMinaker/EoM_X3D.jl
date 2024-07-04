function animate_history(
    system::EoM.mbd_system,
    pout,
    tout,
    verbose::Bool=false;
    folder="output",
    filename::String=system.name,
    overwrite::Bool=true
)
    ## Copyright (C) 2017, Bruce Minaker
    ## animate_history.jl is free software; you can redistribute it and/or modify it
    ## under the terms of the GNU General Public License as published by
    ## the Free Software Foundation; either version 2, or (at your option)
    ## any later version.
    ##
    ## animate_history.jl is distributed in the hope that it will be useful, but
    ## WITHOUT ANY WARRANTY; without even the implied warranty of
    ## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    ## General Public License for more details at www.gnu.org/copyleft/gpl.html.
    ##
    ##--------------------------------------------------------------------

    ## This function takes the time history of the system, and passes it to the animator

    verbose && println("Animating history...")

    dir_date = EoM.setup(; folder)

    dir = joinpath(dir_date, filename)
    !isdir(dir) && (mkdir(dir))

    # remove and recreate x3d folder (default), or not
    if overwrite
        dir = joinpath(dir_date, filename, "x3d")
        rm(dir, recursive=true, force=true)
        mkdir(dir)
    else
        tmstr = Dates.format(now(), "HH-MM-SS-s")
        dir = joinpath(dir_date, filename, "x3d_" * tmstr)
        mkdir(dir)
    end

    l = range(1, step=Int(round(0.05 / tout.step.hi)), stop=length(tout))

    pout = pout[:, l]
    tout = tout[l]

    ## Add the static location to the displacement
    for j = 1:length(system.bodys)-1  ## For each body
        pout[6*j.+(-5:-3), :] += system.bodys[j].location * ones(1, size(pout, 2))
    end

    pout = item_locations(system, pout)  ## Compute locations of the connecting items
    pout = pout'

    x3d_body!(system)  ## Fill in the default graphics data
    x3d_connections!(system)  ## Fill in the connection data
    x3d_animate(system, tout, pout, joinpath(dir, "history.html"))

    verbose && println("Animations complete.")

    nothing

end

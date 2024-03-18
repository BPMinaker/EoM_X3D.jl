function animate_history(folder, mbd, pout, tout; verbose=false)
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

    l = range(1, step=Int(round(0.05 / tout.step.hi)), stop=length(tout))

    pout = pout[:, l]
    tout = tout[l]

    dir = joinpath(folder, "x3d")
    if (~isdir(dir))
        mkdir(dir)
    end

    for j = 1:length(mbd.system.bodys)-1  ## For each body
        pout[6*j-5:6*j-3, :] += mbd.system.bodys[j].location * ones(1, size(pout, 2))  ## Add the static location to the displacement
    end

    pout = item_locations(mbd.system, pout)  ## Compute locations of the connecting items
    pout = pout'

    x3d_animate(mbd.system, tout, pout, joinpath(dir, "history.html"))

    verbose && println("Animations complete.")

    nothing

end

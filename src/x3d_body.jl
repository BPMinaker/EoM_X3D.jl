function x3d_body!(syst::EoM.mbd_system)

    ## GPL here
    # This function builds an x3d model

    x3d_tags = ["ground" "upright" "strut" "arm" "wheel" "chassis" "rack" "crank" "rod" "bar"]  ## Define significant body names
    for i in syst.bodys  ## Loop over each body
        x3d = x3d_pnt([0, 0, 0], cubes=true, rad=[0.045, 0.045, 0.045], col=[0.5, 0, 0], tran=0.3)  ## Define default x3d string
        for j in eachindex(x3d_tags)  ## Loop over each sig. name
            if occursin(x3d_tags[j], lowercase(i.name))  ## If the body name contains a sig. name, replace the default string
                lcn = i.location  ## Record that body"s location
                if j == 1 # ground
                    x3d = x3d_cyl([[0, 0, 0] [0, 0, -0.01]], rad=3, col=[0, 0.4, 0], tran=0.5)
                    x3d *= x3d_pnt([0, 0, 0], cubes=true, rad=[3, 1.5, 0.01], col=[0.25, 0.25, 0.25], tran=0.5)
                elseif j == 2 || j == 3 || j == 4 # "upright" or "strut" or "arm"
                    x3d = x3d_pnt([0, 0, 0], rad=0.03, col=[0.5, 0, 0])
                elseif j == 5 # "wheel"
                    rr = abs(lcn[3])
                    rr == 0 && (rr = 0.3)
                    x3d = x3d_cyl([[0, rr / 4, 0] [0, -rr / 4, 0]], rad=rr, col=[0.05, 0.05, 0.05], tran=0.4, shin=1.0)
                    x3d *= x3d_cyl([[0, rr / 3.9, 0] [0, -rr / 3.9, 0]], rad=0.8 * rr, col=[0.25, 0.25, 0.25], tran=0.8)
                elseif j == 6 # "chassis"
                    x3d = x3d_pnt([0, 0, 0], cubes=true, rad=[0.8, 0.3, 0.4], col=[0, 0, 0.5], tran=0.3)
                elseif j == 7 # "rack"
                    x3d = x3d_cyl([[0, -0.1, 0] [0, 0.1, 0]], rad=0.05, col=rand(3, 1))
                elseif j == 8 # "crank"
                    x3d = x3d_pnt([0, 0, 0], rad=0.02, col=[0.5, 0, 0])
                elseif j == 9 || j == 10 # "rod" or "bar"
                    x3d = x3d_pnt([0, 0, 0], rad=0.015, col=[0.5, 0, 0])
                end
            end
        end
        i.x3d *= x3d  ## Add the x3d to the body
    end
end  ## Leave

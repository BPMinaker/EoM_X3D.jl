function x3d_animate(syst, tout, pout, file_name)
    ## Copyright (C) 2010, Bruce Minaker, Rob Rieveley
    ## This file is intended for use with Octave.
    ## x3d_animate.m is free software; you can redistribute it and/or modify it
    ## under the terms of the GNU General Public License as published by
    ## the Free Software Foundation; either version 2, or (at your option)
    ## any later version.
    ##
    ## x3d_animate.m is distributed in the hope that it will be useful, but
    ## WITHOUT ANY WARRANTY; without even the implied warranty of
    ## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    ## General Public License for more details at www.gnu.org/copyleft/gpl.html.
    ##
    ##--------------------------------------------------------------------

    ## This function draws the animated x3d file of the system

    nbodys = length(syst.bodys)
    nsolid = nbodys - 1
    npoint = length(syst.rigid_points) + length(syst.flex_points) + length(syst.loads)
    nline = length(syst.links) + length(syst.springs) + length(syst.beams) + length(syst.sensors) + length(syst.actuators)

    tscale = tout[end]
    tout /= tscale

    s1 = ""
    for j in 1:nbodys
        lcns = syst.bodys[j].location
        name = syst.bodys[j].name

        if name != "ground" ## If we have a body that's not ground, cause the ground doesn't move

            trans = pout[:, 6*j.+(-5:-3)]  ## Pull coordinates from input
            rots = hcat(pout[:, 6*j.+(-2:0)], zeros(size(pout, 1)))

            temp1 = trans'
            temp2 = rots'

            for k = 1:size(pout, 1)
                temp2[4, k] = norm(temp2[1:3, k]) # need to check the rotations plot
            end

            s1 *= x3d_motion(tout, temp1, temp2, "$(j)_body", syst.bodys[j].x3d) ## Add the x3d string for the motion indicated by the mode shape
        else
            s1 *= syst.bodys[j].x3d ## Ground doesn't move
        end
    end


    for j in eachindex(syst.rigid_points)
        item = syst.rigid_points[j]

        ind = 6 * nsolid + 3 * j .+ (-2:0)
        lcn = pout[:, ind]'
        n = size(pout, 1)
        rot = vcat(zeros(2, n), ones(1, n), zeros(1, n))

        if (item.forces == 3 || item.forces == 0) && (item.moments == 3 || item.moments == 0)
            x3d = x3d_pnt([0, 0, 0], rad=0.025, col=[0, 0, 0.5])
        else
            x3d = x3d_cyl([-0.025 * (item.axis) / norm(item.axis) 0.025 * (item.axis) / norm(item.axis)], rad=0.02, col=[0, 0, 0.5])
        end
        s1 *= x3d_motion(tout, lcn, rot, "$(j)_rigid_point", x3d) ## Add the x3d string for the motion indicated by the mode shape
    end

    for j in eachindex(syst.flex_points)
        item = syst.flex_points[j]

        ind = 6 * nsolid + 3 * length(syst.rigid_points) + 3 * j .+ (-2:0)
        lcn = pout[:, ind]'

        n = size(pout, 1)
        rot = vcat(zeros(2, n), ones(1, n), zeros(1, n))

        if (item.forces == 3 || item.forces == 0) && (item.moments == 3 || item.moments == 0)
            x3d = x3d_pnt([0, 0, 0], rad=0.025, col=[0.5, 0.5, 0])
        else
            x3d = x3d_cyl([-0.025 * (item.axis) / norm(item.axis) 0.025 * (item.axis) / norm(item.axis)], rad=0.021, col=[0.5, 0.5, 0])
        end
        s1 *= x3d_motion(tout, lcn, rot, "$(j)_flex_point", x3d) ## Add the x3d string for the motion indicated by the mode shape
    end

    s2 = ""
    link_rad = 0.01
    for j in eachindex(syst.links)
        len = norm(syst.links[j].location[2] - syst.links[j].location[1])  ## build x3d link
        x3d_link = x3d_cyl([[0, 0, 0] [0, len, 0]], rad=link_rad, col=[0, 0.5, 0])

        ind1 = 6 * nsolid + 3 * npoint + 6 * j .+ (-5:-3)
        ind2 = 6 * nsolid + 3 * npoint + 6 * j .+ (-2:0)

        lcn1 = pout[:, ind1]'
        lcn2 = pout[:, ind2]'

        aa = zeros(4, size(pout, 1))
        for i in 1:size(pout, 1)
            aa[1:4, i] = axisang(lcn2[:, i], lcn1[:, i])' # change each column from end points to axis and angle form for x3d standard
        end
        s2 *= x3d_motion(tout, lcn1, aa, "$(j)_link", x3d_link) # insert the picture of the arm into the animation data
    end

    s3 = ""
    s4 = ""
    link_rad = 0.015
    for j in eachindex(syst.springs)
        len = 0.65 * syst.springs[j].length
        twist = syst.springs[j].twist

        if twist == 0
            x3d_spring = x3d_cyl([[0, 2 * link_rad, 0] [0, len, 0]], rad=2.5 * link_rad, col=[0.5, 0.5, 0], tran=0.3)
            x3d_spring *= x3d_pnt([0, 0, 0], rad=2 * link_rad, col=[0.5, 0.5, 0])

            x3d_spring_out = x3d_cyl([[0, 2 * link_rad, 0] [0, len, 0]], rad=3 * link_rad, col=[0.5, 0.5, 0], tran=0.3)
            x3d_spring_out *= x3d_cyl([[0, 0, 0] [0, len + link_rad, 0]], rad=link_rad, col=[0.5, 0.5, 0.5])
            x3d_spring_out *= x3d_cyl([[0, len - link_rad, 0] [0, len + link_rad, 0]], rad=2.3 * link_rad, col=[0.5, 0.5, 0.5])
            x3d_spring_out *= x3d_pnt([0, 0, 0], rad=2 * link_rad, col=[0.5, 0.5, 0])
        else
            x3d_spring = x3d_cyl([[0, 2 * link_rad, 0] [0, 0.77 * len, 0]], rad=1.5 * link_rad, col=[0.5, 0.5, 0], tran=0.3)
            x3d_spring *= x3d_pnt([0, 0, 0], rad=2 * link_rad, col=[0.5, 0.5, 0])
            x3d_spring_out = x3d_cyl([[0, 2 * link_rad, 0] [0, 0.77 * len, 0]], rad=1.5 * link_rad, col=[0.5, 0.5, 0], tran=0.3)
            x3d_spring_out *= x3d_pnt([0, 0, 0], rad=2 * link_rad, col=[0.5, 0.5, 0])
        end
        ind1 = 6 * nsolid + 3 * npoint + 6 * length(syst.links) + 6 * j .+ (-5:-3)
        ind2 = 6 * nsolid + 3 * npoint + 6 * length(syst.links) + 6 * j .+ (-2:0)

        lcn1 = pout[:, ind1]'
        lcn2 = pout[:, ind2]'

        aa1 = zeros(4, size(pout, 1))
        aa2 = zeros(4, size(pout, 1))
        for i = 1:size(pout, 1)
            aa1[1:4, i] = axisang(lcn2[:, i], lcn1[:, i])' # change each column from end points to axis and angle form for x3d standard
            aa2[1:4, i] = axisang(lcn1[:, i], lcn2[:, i])'
        end
        s3 *= x3d_motion(tout, lcn1, aa1, "$(j)_spring", x3d_spring) # insert the picture of the arm into the animation data
        s4 *= x3d_motion(tout, lcn2, aa2, "$(j)_spring_out", x3d_spring_out)
    end

    s = s1 * s2 * s3 * s4
    x3d_save(s, file_name, tscale)
end  ## Leave

#			str=['x3d=''' syst.bodys(j).x3d ''';']  ## and this body has an x3d description
#			eval(str);

function item_locations(syst, pout)
## Copyright (C) 2017, Bruce Minaker
## This file is intended for use with Octave.
## item_locations.jl is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2, or (at your option)
## any later version.
##
## item_locations.jl is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details at www.gnu.org/copyleft/gpl.html.
##
##--------------------------------------------------------------------

## This function computes the locations of the connector item endpoints from body position time history

    temp = [pout;zeros(6, size(pout, 2))]  ## Add zeros for ground for now
    enda = zeros(3, size(pout, 2))

    for j in syst.rigid_points
        bnum1 = j.body_number[1]  ## Find body numbers
        bnum2 = j.body_number[2]
        for k = 1:size(pout, 2)
            end1 = temp[6 * bnum1 .+ (-5:-3),k] + (diagm(ones(3)) + EoM.skew(temp[6 * bnum1 .+ (-2:0),k])) * j.radius[1]  ## Find end locations
            end2 = temp[6 * bnum2 .+ (-5:-3),k] + (diagm(ones(3)) + EoM.skew(temp[6 * bnum2 .+ (-2:0),k])) * j.radius[2]
            enda[:,k] = (end1 + end2) / 2
        end
    pout = [pout;enda]  ## Add rigid_point locations to output
    end

    for j in syst.flex_points
        bnum1 = j.body_number[1]  ## Find body numbers
        bnum2 = j.body_number[2]
        for k = 1:size(pout, 2)
            end1 = temp[6 * bnum1 .+ (-5:-3),k] + (diagm(ones(3)) + EoM.skew(temp[6 * bnum1 .+ (-2:0),k])) * j.radius[1]  ## Find end locations
            end2 = temp[6 * bnum2 .+ (-5:-3),k] + (diagm(ones(3)) + EoM.skew(temp[6 * bnum2 .+ (-2:0),k])) * j.radius[2]
            enda[:,k] = (end1 + end2) / 2
        end
	    pout = [pout;enda]  ## Add flex_point locations to output
    end

    for j in syst.loads
        bnum = j.body_number  ## Find body numbers
        for k = 1:size(pout, 2)
            enda[:,k] = temp[6 * bnum .+ (-5:-3),k] + (diagm(ones(3)) + EoM.skew(temp[6 * bnum .+ (-2:0),k])) * j.radius  ## Find end locations
        end
        pout = [pout;enda]  ## Add load end locations to output
    end

    end1 = zeros(3, size(pout, 2));
    end2 = zeros(3, size(pout, 2));

    for j in syst.links
        bnum1 = j.body_number[1]  ## Find body numbers
        bnum2 = j.body_number[2]
        for k = 1:size(pout, 2)
            end1[:,k] = temp[6 * bnum1 .+ (-5:-3),k] + (diagm(ones(3)) + EoM.skew(temp[6 * bnum1 .+ (-2:0),k])) * j.radius[1]  ## Find spring end locations
            end2[:,k] = temp[6 * bnum2 .+ (-5:-3),k] + (diagm(ones(3)) + EoM.skew(temp[6 * bnum2 .+ (-2:0),k])) * j.radius[2]
        end
        pout = [pout;end1;end2]  ## Add link end locations to output
    end

    for j in syst.springs
        bnum1 = j.body_number[1]  ## Find body numbers
        bnum2 = j.body_number[2]
        for k = 1:size(pout, 2)
            end1[:,k] = temp[6 * bnum1 .+ (-5:-3),k] + (diagm(ones(3)) + EoM.skew(temp[6 * bnum1 .+ (-2:0),k])) * j.radius[1]  ## Find spring end locations
            end2[:,k] = temp[6 * bnum2 .+ (-5:-3),k] + (diagm(ones(3)) + EoM.skew(temp[6 * bnum2 .+ (-2:0),k])) * j.radius[2]
        end
        pout = [pout;end1;end2]  ## Add spring end locations to output
    end

    pout
end  ## Leave

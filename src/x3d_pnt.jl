function x3d_pnt(x; cubes=false, rad=[0.01, 0.01, 0.01], tran=0, shin=0.5, col=[0.3, 0.4, 0.9])

    ## Copyright (C) 2017 Bruce Minaker
    ##
    ## This program is free software; you can redistribute it and/or modify it
    ## under the terms of the GNU General Public License as published by the
    ## Free Software Foundation; either version 2, or (at your option) any
    ## later version.
    ##
    ## This is distributed in the hope that it will be useful, but WITHOUT
    ## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    ## FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    ## for more details.
    ##

    ## A version of E. Grossmann's vrml_cyl, modified to generate x3d format code, rather than VRML
    ## Modification by Bruce Minaker, Jan. 2006
    ## Original Author:        Etienne Grossmann <etienne@cs.uky.edu>

    s = ""
    n = size(x, 2)
    cs = join(string.(col), " ")

    if cubes
        shptype = "Box "
        radtype = "size='"
        radius = join(string.(rad), " ")
    else
        shptype = "Sphere "
        radtype = "radius='"
        radius = "$(rad[1])"
    end

    for i in 1:n
        xs = join(string.(x[:,i]), " ")
        s *= """
<Transform translation='$(xs)' >
 <Shape>
  <$(shptype)$(radtype)$(radius)'></$(shptype)>
  <Appearance>
   <Material emissiveColor='$(cs)' diffuseColor='$(cs)' specularColor='1 1 1' shininess='$(shin)' transparency='$(tran)'/>
  </Appearance>
 </Shape>
</Transform>
"""
    end
    s
end

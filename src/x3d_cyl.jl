function x3d_cyl(x; rad=0.005, cone::Bool=false, tran=0.0, shin=0.5, col=[0.3, 0.4, 0.9])

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
    ## Modification by Bruce Minaker, Jan. 2017
    ## Original Matlab version author: Etienne Grossmann <etienne@cs.uky.edu>

    s = ""
    n = size(x, 2)
    cs = join(string.(col), " ")

    if cone
        shptype = "Cone "
        radtype = " bottomRadius="
    else
        shptype = "Cylinder "
        radtype = " radius="
    end

    for i in 2:n
        d = x[:, i] - x[:, i-1]
        seglen = norm(d)
        if seglen > 0
            t = 0.5 * (x[:, i-1] + x[:, i])
            ts = join(string.(t), " ")
            aa = axisang(x[:, i], x[:, i-1])
            aas = join(string.(aa), " ")
            s *= """
<Transform translation='$(ts)' rotation='$(aas)'>
 <Shape>
  <$(shptype)height=$(seglen)$(radtype)$(rad)></$(shptype)>
  <Appearance>
   <Material emissiveColor='$(cs)' diffuseColor='$(cs)' specularColor='1 1 1' shininess='$(shin)' transparency='$(tran)'/>
  </Appearance>
 </Shape>
</Transform>
"""
        end
    end
    s
end

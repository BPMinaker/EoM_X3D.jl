function x3d_ifs(; pstn=[0, 0, 0], rotn=[0, 0, 10], vert=[[0, 0, 0] [1, 0, 0] [1, 1, 0] [0, 1, 0]], faces=[0, 1, 2, 3, -1])

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

    tran = 0
    col = [0.3, 0.4, 0.9]
    cs = join(string.(col), " ")


    i = 1
    while i <= nargin
        tmp = varargin[i]
        i += 1
        if tmp == "col"
            col = varargin[i]
            i += 1
        elseif tmp == "tran"
            tran = varargin[i]
            i += 1
        end
    end

    s = ""
    n = size(pstn, 2)

    for i in 1:n
        ps = join(string.(pstn[:,i]), " ")
        rs = join(string.(rotn[:,i]), " ")

        if tran > 0
            tran_s = " transparency=$(tran[i])"  # something broken here? 
        else
            tran_s = ""
        end
    s *= """
<Transform translation='$(ps)' rotation='$(rs)'>
 <Shape>
  <Appearance>
   <Material  emissiveColor='$(cs)' diffuseColor='$(cs)'$(tran_s)/>
  </Appearance>
  <IndexedFaceSet coordIndex='$(join([join(faces[:, j], " ") for j in axes(faces, 2)], ""))'>
   <Coordinate point='$(join([join(vert[:, j], " ") for j in axes(vert, 2)], ""))'/>
  </IndexedFaceSet>
 </Shape>
</Transform>"""
    end
    s
end

function x3d_cyl(x;rad=0.005,cone=false,tran=0,shin=0.5,col=[0.3,0.4,0.9])

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

    s=""
    n=size(x,2)

    if cone
        shptype="Cone "
        radtype=" bottomRadius="
    else
        shptype="Cylinder "
        radtype=" radius="
    end

    for i=2:n
        d=x[:,i]-x[:,i-1]
        n=norm(d)
        if n>0
            t=0.5*(x[:,i-1]+x[:,i])
            aa=axisang(x[:,i],x[:,i-1])

            pstn="'$(t[1]) $(t[2]) $(t[3])'"
            rtn="'$(aa[1]) $(aa[2]) $(aa[3]) $(aa[4])'"
            radius="'$rad'"
            height="'$n'"
            color="'$(col[1]) $(col[2]) $(col[3])'"
            trans=" transparency='$tran'"
            shiny=" shininess='$shin'"


            s*="<Transform translation="*pstn*" rotation="*rtn*">\n"
            s*=" <Shape>\n"
            s*="  <"*shptype*"height="*height*radtype*radius*"></"*shptype*">\n"
            s*="  <Appearance>\n"
            s*="   <Material emissiveColor="*color*" diffuseColor="*color*" specularColor='1 1 1'"*shiny*trans*"></Material>\n"
            s*="  </Appearance>\n"
            s*=" </Shape>\n"
            s*="</Transform>\n"
        end
    end
    s
end

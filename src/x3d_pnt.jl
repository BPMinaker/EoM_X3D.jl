function x3d_pnt(x;cubes=false,rad=[0.01,0.01,0.01],tran=0,col=[0.3,0.4,0.9])

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

s=""
n=size(x,2)

if cubes
	shptype="Box "
	radtype="size='"
	radius="$(rad[1]) $(rad[2]) $(rad[3])"
else
	shptype="Sphere "
	radtype="radius='"
	radius="$(rad[1])"
end

for i=1:n
	pstn="$(x[1,i]) $(x[2,i]) $(x[3,i])"
	color="'$(col[1]) $(col[2]) $(col[3])'"
	trans=" transparency='$tran'"

	s*="<Transform translation='"*pstn*"' >\n"
	s*=" <Shape>\n"
	s*="  <"*shptype*radtype*radius*"'></"*shptype*">\n"
	s*="  <Appearance>\n"
	s*="   <Material emissiveColor="*color*" diffuseColor="*color*trans*"></Material>\n"
	s*="  </Appearance>\n"
	s*=" </Shape>\n"
	s*="</Transform>\n"
end

s
end

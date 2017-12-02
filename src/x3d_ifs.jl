function x3d_ifs(;pstn=[0,0,0],rotn=[0,0,10],vert=[[0,0,0] [1,0,0] [1,1,0] [0,1,0]],faces=[0,1,2,3,-1])

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

tran=0
col=[0.3,0.4,0.9]

i=1
while i<=nargin
	tmp=varargin[i]
	i+=1
	if tmp=="col"
		col=varargin[i]
		i+=1
	elseif tmp=="tran"
		tran=varargin[i]
		i+=1
	end
end

s=""
n=size(pstn,2)

for i=1:n
	pstn_s="'$(pstn[1,i]) $(pstn[2,i]) $(pstn[3,i])'"
	rotn_s="'$(rotn[1,i]) $(rotn[2,i]) $(rotn[3,i])'"
	color="'$(col[1]) $(col[2]) $(col[3])'"
	if tran==1
		trans=" transparency=$(tran[i])"
	else
		tran_s=""
	end
	s*="<Transform translation="*pstn_s*" rotation="*rotn_s*">\n"
	s*=" <Shape>\n"
	s*= "  <Appearance>\n"
	s*= "   <Material  emissiveColor="*color*" diffuseColor="*color*tran_s*"/>\n"
	s*= "  </Appearance>\n"
	s*= " <IndexedFaceSet coordIndex='"
	for j=1:size(faces,2)
		s*="$(faces[1,j]) $(faces[2,j]) $(faces[3,j]) $(faces[4,j]) $(faces[5,j])"
	end
	s*= "'>\n"
	s*="  <Coordinate point='"
	for j=1:size(vert,2)
		s*="$(vert[1,j]) $(vert[2,j]) $(vert[3,j]) $(vert[4,j]) $(vert[5,j])"
	end
	s*= "'/>\n"
	s*= " </IndexedFaceSet>\n"
	s*= " </Shape>\n"
	s*= "</Transform>\n"
end
s
end

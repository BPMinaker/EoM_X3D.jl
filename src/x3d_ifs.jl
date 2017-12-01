function x3d_ifs(varargin)
## Copyright (C) 2010 Bruce Minaker
##
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

##       s=x3d_ifs(x,y...)
##
## Makes an indexed face set that links \
##
## Options :
##
## 'tran', transparency    : Transparency                  default=0
## 'col' , col             : Color           default=[ 0.3 0.4 0.9 ]

## A version of E. Grossmann's vrml_cyl, modified to generate x3d format code, rather than VRML
## Modification by Bruce Minaker, July. 2010
## Original Author:        Etienne Grossmann <etienne@cs.uky.edu>

tran=0
col=[0.3;0.4;0.9]
#emit=0

if(nargin<4)
	pstn=[0;0;0]
	rotn=[0;0;10]
	vert=[[0;0;0],[1;0;0],[1;1;0],[0;1;0]]
	faces=[0;1;2;3;-1]
else
	pstn=varargin[1]
	rotn=varargin[2]
	vert=varargin[3]
	faces=varargin[4]
end

i=1
while(i<=nargin)
	tmp=varargin[i]
    i=i+1
	if(tmp=="col")
		col=varargin[i]
        i=i+1
	elseif(tmp=="tran")
		tran=varargin[i]
        i=i+1
    end
end

s=""
n=size(pstn,2)

# Make col 3xn
if(prod(size(col))==3)
	col=col[:]
	col=col[:,ones(1,n)]
end

col=col*0.5

if(prod(size(tran))==1)
	tran=tran(ones(1,n))
end

for i=1:n
	pstn_s=@sprintf("%f %f %f",pstn[:,i])
	rotn_s=@sprintf("%f %f %f %f",rotn[:,i])
	color=@sprintf("%f %f %f",col[:,i])
	if(tran(i))
		tran_s=@sprintf("transparency=\"%f\"",tran(i))
	else
		tran_s=""
	end

	s*= "<Transform translation=\"" pstn_s "\"  rotation=\"" rotn_s "\" >\n"
	s*= " <Shape>\n"
	s*= "  <Appearance>\n"
	s*= "   <Material  emissiveColor=\"" color "\" diffuseColor=\"" color "\" " tran_s "/>\n"
	s*= "  </Appearance>\n"
	s*= " <IndexedFaceSet coordIndex=\""
	for j=1:size(faces,2)
		s*=@sprintf("%i %i %i %i %i ",faces[:,j])
	end
	s*= "\">\n"
	s*= "  <Coordinate point=\""
	for j=1:size(vert,2)
		s*=@sprintf("%f %f %f ",vert[:,j])
	end
	s*= "\"/>\n"
	s*= " </IndexedFaceSet>\n"
	s*= " </Shape>\n"
	s*= "</Transform>\n"
end
s
end

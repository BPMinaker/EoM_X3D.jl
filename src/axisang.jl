function axisang(x1,x2)
## Copyright (C) 2007, Bruce Minaker
## This file is intended for use with Octave.
## axisang.m is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2, or (at your option)
## any later version.
##
## axisang.m is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details at www.gnu.org/copyleft/gpl.html.
##
##--------------------------------------------------------------------

d=x1-x2
len=norm(d)
if len>0
	d/=len  ## Find the unit vector along the two points
	ax=cross([0,1,0],d)  ## Find the vector in the xz plane that is normal to the unit vector
	an=norm(ax)  ## Find the length of that vector
	if an>0
		ax/=an  ## Find that unit vector if possible
	else
		ax=-d'*[0,1,0]*[1,0,0]  ## Otherwise, the original vector must have been along y axis, so choose x axis, times +/- 1
	end
	aa=zeros(4)
	aa[1:3]=ax  ## This the vector we must rotate around
	aa[4]=acos(d[2])  ## This is the angle we must rotate
	(aa[4]<0) && (aa=-aa)   ## To get positive rotations, we choose the negative axis

else
	aa=[0,0,1,0]
end

aa
end

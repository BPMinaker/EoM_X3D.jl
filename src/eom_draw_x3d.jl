function eom_draw(syst;verbose=false)
## Copyright (C) 2017, Bruce Minaker
## eom_draw.jl is free software you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation either version 2, or (at your option)
## any later version.
##
## eom_draw.jl is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details at www.gnu.org/copyleft/gpl.html.
##
##--------------------------------------------------------------------

## This function draws the X3D file of the system
verbose && println("Drawing x3d...")

syst=x3d_body(syst)  ## Fill in the default graphics data
syst=x3d_connections(syst)  ## Fill in the connection data

s=""
for i=1:syst.data.nbodys
	item=syst.data.bodys[i]

#  	## Add a viewpoint for each body, except ground
#  	lcns=[item.location(:,1)]+[0; 0; 2]
#  	pstn=sprintf('%f %f %f',lcns)
#  	s=[s  '<Viewpoint position="' pstn '"/>\n' ]

	s*="<Transform translation='$(item.location[1]) $(item.location[2]) $(item.location[3])' >\n"*item.x3d*"</Transform>\n"

end

# for i=1:syst.data.nflex_points
# 	item=syst.data.flex_points(i)
# 	lcns=item.location[:,1]
# 	if((item.forces==3||item.forces==0)&&(item.moments==3||item.moments==0))
# 		s*= x3d_pnt(lcns,"rad",0.025,"col",[0 0 1])
# 	else
# 		s*= x3d_cyl([lcns-0.025*(item.axis)/norm(item.axis),lcns+0.025*(item.axis)/norm(item.axis)],"rad",0.02,"col",[0 0 1])
# 	end
# end
#
# for i=1:syst.data.nrigid_points
# 	item=syst.data.rigid_points(i)
# 	lcns=item.location[:,1]
# 	if((item.forces==3||item.forces==0)&&(item.moments==3||item.moments==0))
# 		s*= x3d_pnt(lcns,"rad",0.025,"col",[1 1 0])
# 	else
# 		s*= x3d_cyl([lcns-0.025*(item.axis)/norm(item.axis),lcns+0.025*(item.axis)/norm(item.axis)],"rad",0.02,"col",[1 1 0])
# 	end
# end
#
# link_rad=0.015
# for i=1:syst.data.nsprings
# 	item=syst.data.springs(i)
# 	len=item.length
# 	frac=2*link_rad/len
# 	temp1=(1-frac)*item.location[:,1]+frac*item.location[:,2]
# 	temp2=0.35*item.location[:,1]+0.65*item.location[:,2]
# 	x3d_spring=x3d_cyl([temp1 temp2],"rad",2.5*link_rad,"tran",0.3,"col",[1;1;0])  ## shell inner
# 	x3d_spring*=x3d_pnt(item.location[:,1],"rad",2*link_rad,"col",[1;1;0]) ## ball inner
#
# 	temp1=0.65*item.location[:,1]+0.35*item.location[:,2]
# 	temp2=frac*item.location[:,1]+(1-frac)*item.location[:,2]
# 	x3d_spring_out=x3d_cyl([temp1 temp2],"rad",3*link_rad,"tran",0.3,"col",[1;1;0])  ## shell outer
#
# 	frac=0.65-link_rad/len
# 	temp1=frac*item.location[:,1]+(1-frac)*item.location[:,2]
# 	x3d_spring_out*=x3d_cyl([item.location[:,2] temp1],"rad",link_rad,"col",[1;1;1]) ## shaft
#
# 	frac=0.65+link_rad/len
# 	temp2=frac*item.location[:,1]+(1-frac)*item.location[:,2]
# 	x3d_spring_out*=x3d_cyl([temp1 temp2],"rad",2.3*link_rad,"col",[1;1;1]) ##piston
# 	x3d_spring_out*=x3d_pnt(item.location[:,2],"rad",2*link_rad,"col",[1;1;0]) ## ball outer
#
# 	s*= x3d_spring x3d_spring_out
# end
#
# for i=1:syst.data.nlinks
# 	item=syst.data.links(i)
# 	lcns=[item.location[:,1] item.location[:,2]]
# 	s*= x3d_cyl(lcns,"rad",0.015,"col",[0 1 0])
# end
#
# for i=1:syst.data.nactuators
# 	item=syst.data.actuators(i)
# 	lcns=[item.location[:,1] item.location[:,2]]
# 	s*= x3d_cyl(lcns,"rad",0.01,"col",[0 1 0.5])
# end
#
# for i=1:syst.data.nsensors
# 	item=syst.data.sensors(i)
# 	lcns=[item.location[:,1] item.location[:,2]]
# 	s*= x3d_cyl(lcns,"rad",0.01,"col",[0 0.5 1])
# end
#
# for i=1:syst.data.nbeams
# 	item=syst.data.beams(i)
# 	lcns=[item.location[:,1] item.location[:,2]]
# 	s*= x3d_cyl(lcns,"rad",0.02,"col",[1 0.5 0])
# end
#
# for i=1:syst.data.nloads
# 	item=syst.data.loads(i)
# 	lcns=[item.location]
# 	if(norm(item.force)>0)
# 		dirn=0.2*item.force/norm(item.force)
# 	else
# 		dirn=[0;0;0]
# 	end
# 	s*= x3d_cyl([lcns,lcns+dirn],"rad",0.01,"col",[0 1 1])
# 	s*= x3d_cyl([lcns+dirn,lcns+1.5*dirn],"rad",0.015,"cone","col",[0 1 1])
#
# 	if(norm(item.moment)>0)
# 		dirn=0.2*item.moment/norm(item.moment)
# 	else
# 		dirn=[0;0;0]
# 	end
# 	s*= x3d_cyl([lcns,lcns+dirn],"rad",0.01,"col",[0 1 1])
# 	s*= x3d_cyl([lcns+dirn,lcns+1.5*dirn],"rad",0.015,"cone","col",[0 1 1])
# 	s*= x3d_cyl([lcns+1.3*dirn,lcns+1.8*dirn],"rad",0.015,"cone","col",[0 1 1])
# end
#
# for i=1:syst.data.nnh_points
# 	item=syst.data.nh_points(i)
# 	lcns=item.location[:,1]
# 	if((item.forces==3||item.forces==0)&&(item.moments==3||item.moments==0))
# 		s*= x3d_pnt(lcns,"rad",0.025,"col",[1 1 0.5])
# 	else
# 		s*= x3d_cyl([lcns-0.03*(item.axis)/norm(item.axis),lcns+0.03*(item.axis)/norm(item.axis)],"rad",0.015,"col",[1 1 0.5])
# 	end
# end
#
# for i=1:syst.data.ntriangle_3s
# 	item=syst.data.triangle_3s(i)
# 	lcns=item.location
# 	s*= x3d_ifs([0;0;0],[0;0;1;0],lcns,[0;1;2;-1],"col",[1 0 0.5],"tran",0.5)
# 	avg=(lcns[:,1]+lcns[:,2]+lcns(:,3))/3
# 	s*= x3d_cyl([avg  avg+0.05*item.unit], "col",[1 0 0.5])
# 	s*= x3d_cyl([avg  avg+0.05*item.nu[:,1]], "col",[1 0 0.5])
# 	s*= x3d_cyl([avg  avg+0.05*item.nu[:,2]], "col",[1 0 0.5])
#
# end
#
# x3d_save(s,[syst.config.dir.output filesep() "x3d" filesep() "system.x3d"])
# verb && println("Drawing x3d done.") end

## *** MODIFIED TO DRAW GROUND PLANE AT -152.6mm FOR VEHICLE MODEL ***
##st=[st vrml_surf([0;4],[-1.5,1.5],[-.1526 -.1526;-.1526 -.1526])]
s
end

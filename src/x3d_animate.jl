function x3d_animate(syst,tout,pout,write_file)
## Copyright (C) 2010, Bruce Minaker, Rob Rieveley
## This file is intended for use with Octave.
## x3d_animate.m is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2, or (at your option)
## any later version.
##
## x3d_animate.m is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details at www.gnu.org/copyleft/gpl.html.
##
##--------------------------------------------------------------------

## This function draws the animated x3d file of the system

println("Animating...")

syst=x3d_body(syst)  ## Fill in the default graphics data
syst=x3d_connections(syst)  ## Fill in the connection data

nbodys=syst.data.nbodys
nsolid = syst.data.nbodys-1
npoint = syst.data.nrigid_points+syst.data.nflex_points+syst.data.nloads+syst.data.nmarkers
nline = syst.data.nlinks+syst.data.nsprings+syst.data.nbeams+syst.data.nsensors+syst.data.nactuators

s1=""
for j=1:nbodys
	lcns=syst.data.bodys[j].location
	name=syst.data.bodys[j].name

	if (name !== "ground") ## If we have a body that's not ground, cause the ground doesn't move

		trans=pout[:,6*j-5:6*j-3]  ## Pull coordinates from input
		rots=pout[:,6*j-2:6*j]

		temp1=trans'
		temp2=rots'

		for k=1:size(pout,1)
			temp2[4,k]=norm(temp2[1:3,k]) # need to check the rotations plot
		end

		s1*=x3d_motion(tout,temp1,temp2,ones(3,size(pout,1)),"$j_body",syst.data.bodys[j].x3d) ## Add the x3d string for the motion indicated by the mode shape
	else
		s1*= syst.data.bodys[j].x3d ## Ground doesn't move
	end
end


for j=1:syst.data.nrigid_points

	item=syst.data.rigid_points[j]

	ind=[6*nsolid+3*j+[-2:0]]
	lcn=pout[:,ind]'

	for k=1:size(pout,1)
		rot[:,k]=[0,0,1,0]
	end

	if((item.forces==3||item.forces==0)&&(item.moments==3||item.moments==0))
		x3d=x3d_pnt([0,0,0],"rad",0.025,"col",[0 0 1])
	else
		x3d=x3d_cyl([-0.025*(item.axis)/norm(item.axis),0.025*(item.axis)/norm(item.axis)],"rad",0.02,"col",[1 1 0])
	end
	s1*=x3d_motion(tout,lcn,rot,ones(3,size(pout,1)),"$j_rigid_point",x3d) ## Add the x3d string for the motion indicated by the mode shape
end

for j=1:syst.data.nflex_points

	item=syst.data.flex_points(j)

	ind=[6*nsolid+3*syst.data.nrigid_points+3*(j)+[-2:0]]
	lcn=pout(:,ind)'

	for k=1:size(pout,1)
		rot(:,k)=[0;0;1;0]
	end

	if((item.forces==3||item.forces==0)&&(item.moments==3||item.moments==0))
		x3d=x3d_pnt([0;0;0],"rad",0.025,"col",[0 0 1])
	else
		x3d=x3d_cyl([-0.025*(item.axis)/norm(item.axis),0.025*(item.axis)/norm(item.axis)],"rad",0.02,"col",[0 0 1])
	end
	s1*=x3d_motion(tout,lcn,rot,ones(3,size(pout,1)),"$j_flex_point",x3d) ## Add the x3d string for the motion indicated by the mode shape
end


s2=""
link_rad=0.01
for j=1:syst.data.nlinks
	len=norm(syst.data.links(j).location(:,2)-syst.data.links(j).location(:,1))  ## build x3d link
	x3d_link=x3d_cyl([[0;0;0] [0;len;0]],"rad",link_rad,"col",[0;1;0])

	ind1=[6*nsolid+3*npoint+6*(j)+[-5:-3]]
	ind2=[6*nsolid+3*npoint+6*(j)+[-2:0]]

	lcn1=pout(:,ind1)'
	lcn2=pout(:,ind2)'

	for i=1:size(pout,1)
		scale(:,i)=[1;norm(lcn2[:,i]-lcn1[:,i])/len;1]
		aa[1:4,i]=axisang(lcn2[:,i],lcn1[:,i])' # change each column from end points to axis and angle form for x3d standard
	end
	s2*=x3d_motion(tout,lcn1,aa,scale,"$j_link",x3d_link) # insert the picture of the arm into the animation data
end

s3=""
s4=""
link_rad=0.015
for j=1:syst.data.nsprings
#	len=norm(syst.data.springs(j).location1-syst.data.springs(j).location2)
	len=syst.data.springs(j).length

	x3d_spring=x3d_cyl([[0;2*link_rad;0] [0;0.65*len;0]],"rad",2.5*link_rad,"tran",0.3,"col",[1;1;0])
	x3d_spring*=x3d_pnt([0;0;0],"rad",2*link_rad,"col",[1;1;0])

	len=len*.65
	x3d_spring_out=x3d_cyl([[0;2*link_rad;0] [0;len;0]],"rad",3*link_rad,"tran",0.3,"col",[1,1,0])
	x3d_spring_out*=x3d_cyl([[0;0;0] [0;len+link_rad;0]],"rad",link_rad,"col",[1;1;1])
	x3d_spring_out*=x3d_cyl([[0;len-link_rad;0] [0,len+link_rad,0]],"rad",2.3*link_rad,"col",[1,1,1])
	x3d_spring_out*=x3d_pnt([0;0;0],"rad",2*link_rad,"col",[1,1,0])

	ind1 = [6*nsolid+3*npoint+6*syst.data.nlinks+6*j+[-5:-3]]
	ind2 = [6*nsolid+3*npoint+6*syst.data.nlinks+6*j+[-2:0]]

	lcn1=pout[:,ind1]'
	lcn2=pout[:,ind2]'

	for i=1:size(pout,1)
		aa1[1:4,i]=axisang(lcn2[:,i],lcn1[:,i])' # change each column from end points to axis and angle form for x3d standard
		aa2[1:4,i]=axisang(lcn1[:,i],lcn2[:,i])'
	end
	s3*=x3d_motion(tout,lcn1,aa1,ones(3,size(pout,1)),"$j_spring",[x3d_spring]) # insert the picture of the arm into the animation data
	s4*=x3d_motion(tout,lcn2,aa2,ones(3,size(pout,1)),"$j_spring_out",x3d_spring_out)
end

s=[s1 s2 s3 s4]
x3d_save(s,[write_file ".x3d"])
println("Animation complete.")
end  ## Leave

#			str=['x3d=''' syst.data.bodys(j).x3d ''';']  ## and this body has an x3d description
#			eval(str);

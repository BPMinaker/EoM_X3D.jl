function syst=x3d_connections(syst)

## GPL here
# This function builds an x3d model

link_rad=0.018
color=[0.5;0.5;0.5]


for i=1:syst.data.nrigid_points  ## For every rigid point
	joint_lcn=syst.data.rigid_points(i).location  ## Find the location
	for j=1:2  ## For each body it attachs
		this_body_name=syst.data.bodys(syst.data.rigid_points(i).body_number(j)).name
		if(~strcmp(this_body_name,"ground")&&~strcmp(this_body_name,"chassis")   )  ## If it's not the ground or the chassis
			body_lcn=syst.data.bodys(syst.data.rigid_points(i).body_number(j)).location  ## Find the body location
			x3d=[x3d_cyl([[joint_lcn-body_lcn] [0;0;0]],"rad",link_rad,"col",color)]  ## Draw the connection
			syst.data.bodys(syst.data.rigid_points(i).body_number(j)).x3d=[syst.data.bodys(syst.data.rigid_points(i).body_number(j)).x3d x3d]  ## Add the x3d to the body
		end
	end
end

for i=1:syst.data.nlinks  ## For every link
	for j=1:2  ## For each body it attachs
		joint_lcn=syst.data.links(i).location(:,j)  ## Find the location
		body_lcn=syst.data.bodys(syst.data.links(i).body_number(j)).location  ## Find the body location
		x3d=x3d_pnt([joint_lcn-body_lcn],"rad",link_rad+0.002,"col",[1;0;0])
		this_body_name=syst.data.bodys(syst.data.links(i).body_number(j)).name
		if(~strcmp(this_body_name,"ground")&&~strcmp(this_body_name,"chassis")   )  ## If it's not the ground or the chassis
			x3d=[x3d x3d_cyl([[joint_lcn-body_lcn] [0;0;0]],"rad",link_rad,"col",color)]  ## Draw the link mount
 		end
		syst.data.bodys(syst.data.links(i).body_number(j)).x3d=[syst.data.bodys(syst.data.links(i).body_number(j)).x3d x3d]  ## Add the x3d to the body
	end
end

for i=1:syst.data.nsprings  ## For every spring
  	for j=1:2  ## For each body it attachs
		joint_lcn=syst.data.springs(i).location(:,j)  ## Find the location
		body_lcn=syst.data.bodys(syst.data.springs(i).body_number(j)).location  ## Find the body location
		this_body_name=syst.data.bodys(syst.data.springs(i).body_number(j)).name
		if(~strcmp(this_body_name,"ground")&&~strcmp(this_body_name,"chassis")   )  ## If it's not the ground or the chassis
			x3d=[x3d_cyl([[joint_lcn-body_lcn] [0;0;0]],"rad",link_rad,"col",color)]  ## Draw the spring mount
			syst.data.bodys(syst.data.springs(i).body_number(j)).x3d=[syst.data.bodys(syst.data.springs(i).body_number(j)).x3d x3d]  ## Add the x3d to the body
		end
	end
end

end  ## Leave

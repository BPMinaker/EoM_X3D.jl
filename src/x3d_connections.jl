function x3d_connections(syst)

## GPL here
# This function builds an x3d model

link_rad=0.018
color=[0.25,0.25,0.25]

for i in syst.rigid_points  ## For every rigid point
	joint_lcn=i.location  ## Find the location
	for j=1:2  ## For each body it attachs
		this_body_name=lowercase(syst.bodys[i.body_number[j]].name)
		if (this_body_name!="ground") && (this_body_name!="chassis") && !contains(this_body_name,"wheel")    ## If it's not the ground or the chassis
			body_lcn=syst.bodys[i.body_number[j]].location  ## Find the body location
			x3d=x3d_cyl([(joint_lcn-body_lcn) [0,0,0]],rad=link_rad,col=color)  ## Draw the connection
			syst.bodys[i.body_number[j]].x3d*=x3d  ## Add the x3d to the body
		end
	end
end

for i in syst.links  ## For every link
	for j=1:2  ## For each body it attachs
		joint_lcn=i.location[j]  ## Find the location
		body_lcn=syst.bodys[i.body_number[j]].location  ## Find the body location
		x3d=x3d_pnt((joint_lcn-body_lcn),rad=link_rad+0.002,col=[1,0,0])
		this_body_name=lowercase(syst.bodys[i.body_number[j]].name)
		if (this_body_name!=="ground") && (this_body_name!=="chassis") ## If it's not the ground or the chassis
			x3d*=x3d_cyl([(joint_lcn-body_lcn) [0,0,0]],rad=link_rad,col=color)  ## Draw the link mount
 		end
		syst.bodys[i.body_number[j]].x3d*=x3d  ## Add the x3d to the body
	end
end

for i in syst.springs  ## For every spring
  	for j=1:2  ## For each body it attachs
		joint_lcn=i.location[j]  ## Find the location
		body_lcn=syst.bodys[i.body_number[j]].location  ## Find the body location
		this_body_name=lowercase(syst.bodys[i.body_number[j]].name)
		if (this_body_name!="ground") && (this_body_name!="chassis") ## If it's not the ground or the chassis
			x3d=x3d_cyl([(joint_lcn-body_lcn) [0,0,0]],rad=link_rad,col=color)  ## Draw the spring mount
			syst.bodys[i.body_number[j]].x3d*=x3d  ## Add the x3d to the body
		end
	end
end
syst
end  ## Leave

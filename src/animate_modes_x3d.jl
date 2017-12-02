function animate_modes(syst,result)
## Copyright (C) 2017, Bruce Minaker
## animate_modes.jl is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2, or (at your option)
## any later version.
##
## animate_modes.jl is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details at www.gnu.org/copyleft/gpl.html.
##
##--------------------------------------------------------------------

## This function computes the time history of the system from the mode vector, and passes it to the animator

println("Animating mode shapes. This may take some time...")

val=result.e_val
vect=result.e_vect
lcns=syst.data.bodys[1:end-1].location

tout=0:1/200:1 ## n point interpolation

modes=vect

#modes=1e-5*round(modes*1e5,RoundNearestTiesAway)
#val=1e-5*round(val*1e5,RoundNearestTiesAway)

# for i=1:size(modes,2)  ## For each mode
# 	if(norm(modes[:,i])>1e-5)  ## Check for non-zero displacement modes
# 		j,k=max(abs(modes[:,i]))  ## Find the dominant motion
# 		modes[:,i]=modes[:,i]*exp(-1im*angle(modes[k,i]))  ## Rotate the phase angle to the dominant motion
# 		modes[:,i]=modes[:,i]/(4*norm(modes[:,i]))  ## Scale motions back to reasonable size
# 		if(real(val(i,i)))  ## If the system is damped
# 			tau=abs(1/real(val(i,i)))  ## Find the time constant (abs in case of unstable)
# 		elseif(imag(val(i,i)))  ## If the undamped oscillatory
# 			tau=abs(pi/imag(val(i,i)))  ## Find the time constant such that two constants gives one cycle
# 		else
# 			tau=1/pi  ## Rigid body mode
# 		end
# 		pout=real(modes[:,i]*exp(val(i,i)*2*tout*tau))  ## Find the time history for two time constants
# 	end
#
# 	for j=1:size(lcns,2)  ## For each body
# 		pout[6*j-5:6*j-3,:]=pout[6*j-5:6*j-3,:]+lcns[:,j]*ones[1,size(pout,2)]  ## Add the static location to the displacement
# 	end
#
# 	pout=item_locations(syst,pout)  ## Compute locations of the connecting items
#
# 	pout=pout'
# 	x3d_animate(syst,tout,pout,joinpath( syst.config.dir.output ,"x3d","mode_$i"))
# end

println("Animations complete.")

end

###########################################3

#	rc(rad,w,v,bodys)  ## Calculate roll centres
## *** MODIFIED TO DRAW GROUND PLANE AT -152.6mm FOR VEHICLE MODEL ***
##st=[st vrml_surf([0;4],[-1.5,1.5],[-.1526 -.1526;-.1526 -.1526])]

#  rad(:,j)=pinv(skew(rots))*trans ## Radius to the instantaneous center of rotation of the body (rad=omega\v)
#  rad(:,j)=1e-6*round(rad(:,j)*1e6)  ## Round off to allow checks
#  if(norm(imag(rad(:,j)))>1e-4)
#  	flag=1
#  end
#  rad(:,j)=real(rad(:,j))  ## This should be a real anyway, but drop the complex parts
#
#  if(norm(real(rots))>1e-4)  ## Draw the instant axis of rotation (in phase)
#  	w=real(rots)
#  	s1=[s1 x3d_cyl([syst.data.bodys(j).location-rad(:,j)-w,syst.data.bodys(j).location-rad(:,j)+w],"rad",0.005,"tran",0.5)]
#  end
#  if(norm(imag(rots))>1e-4)  ## Draw the instant axis of rotation (out of phase)
#  	w=imag(rots)
#  	s1=[s1 x3d_cyl([syst.data.bodys(j).location-rad(:,j)-w,syst.data.bodys(j).location-rad(:,j)+w],"rad",0.005,"tran",0.5)]
#  end



#  if(flag)
#  	disp("Warning: discarding imaginary centre of rotation - likely pure translation.")
#  end

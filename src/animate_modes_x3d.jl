function animate_modes(folder,mbd,result;verbose=false)
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

verbose && println("Animating mode shapes...")

dir=joinpath(folder,"x3d")
if(~isdir(dir))
	mkdir(dir)
end

val=result.mode_vals
modes=result.modes

tout=0:1/200:5.0 ## n point interpolation

for i=1:size(modes,2)  ## For each mode
	if(norm(modes[:,i])>1e-5)  ## Check for non-zero displacement modes

		tau=abs(1/real(val[i]))  ## Find the time constant (abs in case of unstable)
		lam=abs(2pi/imag(val[i]))  ## Find the wavelength
		tt=min(3*tau,lam)
		tt==Inf && (tt=1)

		pout=real(modes[:,i]*exp.(val[i]/5.0*tt*tout'))  ## Find the time history
	else
		pout=zeros(size(modes,1),size(tout,1))
	end

	for j=1:length(mbd.system.bodys)-1  ## For each body
		pout[6*j-5:6*j-3,:]+=mbd.system.bodys[j].location*ones(1,size(pout,2))  ## Add the static location to the displacement
	end

	pout=item_locations(mbd.system,pout)  ## Compute locations of the connecting items
	pout=pout'

	x3d_animate(mbd.system,tout,pout,joinpath(dir,"mode_$i.html"))
end

verbose && println("Animations complete.")

nothing

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
#  	s1=[s1 x3d_cyl([mbd.system.data.bodys(j).location-rad(:,j)-w,mbd.system.data.bodys(j).location-rad(:,j)+w],"rad",0.005,"tran",0.5)]
#  end
#  if(norm(imag(rots))>1e-4)  ## Draw the instant axis of rotation (out of phase)
#  	w=imag(rots)
#  	s1=[s1 x3d_cyl([mbd.system.data.bodys(j).location-rad(:,j)-w,mbd.system.data.bodys(j).location-rad(:,j)+w],"rad",0.005,"tran",0.5)]
#  end



#  if(flag)
#  	disp("Warning: discarding imaginary centre of rotation - likely pure translation.")
#  end

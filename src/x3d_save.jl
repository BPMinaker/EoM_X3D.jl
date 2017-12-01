function x3d_save(frag,flnm)

## Copyright (C) 2017, Bruce Minaker
## x3d_save.jl is free software you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation either version 2, or (at your option)
## any later version.
##
## x3d_save.jl is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details at www.gnu.org/copyleft/gpl.html.
##
##--------------------------------------------------------------------

## This file creates the animated x3d file of the system

s="<?xml version = \"1.0\" encoding = \"UTF-8\"?>\n"   ## xml header
s*="<!DOCTYPE X3D PUBLIC \"ISO//Web3D//DTD X3D 3.1//EN\" \"http://www.web3d.org/specifications/x3d-3.1.dtd\">\n"
s*="<X3D profile=\"Interchange\" version=\"3.1\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema-instance\" xsd:noNamespaceSchemaLocation=\"http://www.web3d.org/specifications/x3d-3.1.xsd\">\n"

s*="<Scene>\n"
## s*=" <Background groundAngle="1.571" groundColor="0 0.3 0, 0 0.2 0" skyAngle="1.571" skyColor="0 0 0.5, 1 1 1"/>\n"]  ## sky and ground background
s*="<Transform rotation="1 0 0 -1.571">\n"  ##  Rotate the entire world to put z up

s*="<Group DEF="axis">\n"  ## Generate the arrows at the origin
s*=" <Transform translation=\"0 0 0.100\" rotation=\"1 0 0 1.571\">\n"
s*="  <Shape DEF=\"cone\">\n"
s*="   <Cone height=\"0.025\"  bottomRadius=\"0.005\"/>\n"
s*="   <Appearance DEF=\"blue\">\n"
s*="     <Material diffuseColor=\"0.0 0.0 0.5\" emissiveColor=\"0.0 0.0 0.5\"/>\n"
s*="   </Appearance>\n"
s*="  </Shape>\n"
s*=" </Transform>\n"

s*=" <Transform translation=\"0 0.100 0\">\n"
s*="  <Shape USE="cone"/>\n"
s*=" </Transform>\n"

s*=" <Transform translation=\"0.100 0 0\" rotation=\"0 0 1 -1.571\">\n"
s*="  <Shape USE="cone"/>\n"
s*=" </Transform>\n"

s*=" <Transform translation=\"0 0 0.050\" rotation=\"1 0 0 1.571\">\n"
s*="  <Shape DEF="cyl">\n"
s*="   <Cylinder height=\"0.090\"  radius=\"0.0025\"/>\n"
s*="   <Appearance USE=\"blue\"/>\n"
s*="  </Shape>\n"
s*=" </Transform>\n"

s*=" <Transform translation=\"0 0.050 0\">\n"
s*="  <Shape USE=\"cyl\"/>\n"
s*=" </Transform>\n"

s*=" <Transform translation=\"0.050 0 0\" rotation=\"0 0 1 -1.571\">\n"
s*="  <Shape USE=\"cyl\"/>\n"
s*=" </Transform>\n"

s*="</Group>\n" ## End of axis arrows

s*="<TimeSensor DEF=\"IDtimer\" loop=\"true\" cycleInterval=\"5.0\" />\n"  ## At the loop timer for the animations
s*=frag  ## Insert the incoming x3d content

s*="</Transform>\n"  ## End of world rotation
s*="</Scene>\n </X3D>\n"  ## End of x3d

open(flnm,"w") do file
	write(file,s)
end

function x3d_save(frag,flnm)
%% Copyright (C) 2005, Bruce Minaker
%% This file is intended for use with Octave.
%% x3d.m is free software; you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2, or (at your option)
%% any later version.
%%
%% x3d.m is distributed in the hope that it will be useful, but
%% WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%% General Public License for more details at www.gnu.org/copyleft/gpl.html.
%%
%%--------------------------------------------------------------------

%% This file creates the animated x3d file of the system

s='<?xml version = "1.0" encoding = "UTF-8"?>\n';   %% xml header
s=[s '<!DOCTYPE X3D PUBLIC "ISO//Web3D//DTD X3D 3.1//EN" "http://www.web3d.org/specifications/x3d-3.1.dtd">\n'];
s=[s '<X3D profile="Interchange" version="3.1" xmlns:xsd="http://www.w3.org/2001/XMLSchema-instance" xsd:noNamespaceSchemaLocation="http://www.web3d.org/specifications/x3d-3.1.xsd">'];
%s=[s '<X3D profile="Immersive" version="3.0" >\n'];

s=[s '<Scene>\n'];
%% s=[s ' <Background groundAngle="1.571" groundColor="0 0.3 0, 0 0.2 0" skyAngle="1.571" skyColor="0 0 0.5, 1 1 1"/>\n'];  %% sky and ground background
s=[s '<Transform rotation="1 0 0 -1.571">\n'];  %%  Rotate the entire world to put z up

s=[s '<Group DEF="axis">\n'];  %% Generate the arrows at the origin
s=[s ' <Transform translation="0 0 0.100" rotation="1 0 0 1.571">\n'];
s=[s '  <Shape DEF="cone">\n'];
s=[s '   <Cone height="0.025"  bottomRadius=".005"/>\n'];
s=[s '   <Appearance DEF="blue">\n'];
s=[s '     <Material diffuseColor="0.0 0.0 0.5" emissiveColor="0.0 0.0 0.5"/>\n'];
s=[s '   </Appearance>\n'];
s=[s '  </Shape>\n'];
s=[s ' </Transform>\n'];

s=[s ' <Transform translation="0 0.100 0">\n'];
s=[s '  <Shape USE="cone"/>\n'];
s=[s ' </Transform>\n'];

s=[s ' <Transform translation="0.100 0 0" rotation="0 0 1 -1.571">\n'];
s=[s '  <Shape USE="cone"/>\n'];
s=[s ' </Transform>\n'];

s=[s ' <Transform translation="0 0 0.050" rotation="1 0 0 1.571">\n'];
s=[s '  <Shape DEF="cyl">\n'];
s=[s '   <Cylinder height="0.090"  radius="0.0025"/>\n'];
s=[s '   <Appearance USE="blue"/>\n'];
s=[s '  </Shape>\n'];
s=[s ' </Transform>\n'];

s=[s ' <Transform translation="0 0.050 0">\n'];
s=[s '  <Shape USE="cyl"/>\n'];
s=[s ' </Transform>\n'];

s=[s ' <Transform translation="0.050 0 0" rotation="0 0 1 -1.571">\n'];
s=[s '  <Shape USE="cyl"/>\n'];
s=[s ' </Transform>\n'];

s=[s '</Group>\n']; %% End of axis arrows

s=[s  '<TimeSensor DEF="IDtimer" loop="true" cycleInterval="5.0" />\n'];  %% At the loop timer for the animations
s=[s frag];  %% Insert the incoming x3d content

s=[s '</Transform>\n'];  %% End of world rotation
s=[s  ' </Scene>\n </X3D>\n'];  %% End of x3d

fd=fopen(flnm,'w');  %% Open, write, and close the x3d file
if(fd<=0)
	pwd
	error('Error opening file "%s"\n', flnm);
end
fprintf(fd,s);
fclose(fd);

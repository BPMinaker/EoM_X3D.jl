function vrml_save(frag,flnm)
%% Copyright (C) 2011, Bruce Minaker
%% This file is intended for use with Octave.
%% vrml.m is free software; you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2, or (at your option)
%% any later version.
%%
%% vrml_save.m is distributed in the hope that it will be useful, but
%% WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%% General Public License for more details at www.gnu.org/copyleft/gpl.html.
%%
%%--------------------------------------------------------------------

%% This file creates the vrml file of the system

s='#VRML V2.0 utf8\n\n';   %% xml header

%% s=[s ' <Background groundAngle="1.571" groundColor="0 0.3 0, 0 0.2 0" skyAngle="1.571" skyColor="0 0 0.5, 1 1 1"/>\n'];  %% sky and ground background
%s=[s 'Transform { rotation 1 0 0 -1.571 children [\n'];  %%  Rotate the entire world to put z up
s=[s 'DEF axis Group{ children [\n'];  %% Define axis group
s=[s 'Transform {\n'];  %% z axis 
s=[s '  translation 0 0 0.100\n'];
s=[s '  rotation 1 0 0 1.571\n'];
s=[s '  children [ DEF cone\n'];
s=[s '    Shape {\n'];
s=[s '      appearance DEF blue Appearance {\n'];
s=[s '        material Material {\n'];
s=[s '          diffuseColor 0.0 0.0 0.5\n'];
s=[s '          emissiveColor 0.0 0.0 0.5\n'];
s=[s '        }\n'];
s=[s '      }\n'];
s=[s '      geometry Cone {\n'];
s=[s '        height 0.025\n'];
s=[s '        bottomRadius 0.005\n'];
s=[s '      }\n'];
s=[s '    }\n'];
s=[s '  ]\n'];
s=[s '}\n'];

s=[s 'Transform {\n'];  %% y-axis
s=[s '  translation 0 0.100 0\n'];
s=[s '  children USE cone\n'];
s=[s '}\n'];

s=[s 'Transform {\n'];  %% x-axis
s=[s '  translation 0.100 0 0\n'];
s=[s '  rotation 0 0 1 -1.571\n'];
s=[s '  children USE cone\n'];
s=[s '}\n'];

s=[s 'Transform {\n'];
s=[s '  translation 0 0 0.050\n'];
s=[s '  rotation 1 0 0 1.571\n'];
s=[s '  children [ DEF cyl\n'];
s=[s '    Shape {\n'];
s=[s '      appearance USE blue\n'];
s=[s '      geometry Cylinder {\n'];
s=[s '        height 0.090 \n'];
s=[s '        radius 0.0025\n'];
s=[s '      }\n'];
s=[s '    }\n'];
s=[s '  ]\n'];
s=[s '}\n'];

s=[s 'Transform {\n'];
s=[s '  translation 0 0.050 0\n'];
s=[s '  children USE cyl\n'];
s=[s '}\n'];
  
s=[s 'Transform {\n'];
s=[s ' translation 0.050 0 0\n'];
s=[s '  rotation 0 0 1 -1.571\n'];
s=[s '  children USE cyl\n'];
s=[s '}\n'];

s=[s ']}\n']; %% End of axis group

s=[s 'DEF IDtimer TimeSensor {\n'];
s=[s '  loop TRUE\n'];
s=[s '  cycleInterval 5.0\n'];  %% Add the loop timer for the animations
s=[s '}\n'];

s=[s frag];  %% Insert the incoming content

%s=[s ']}\n'];  %% End of world rotation
%% End of vrml

fd=fopen(flnm,'w');  %% Open, write, and close the x3d file
if(fd<=0)
	pwd
	error('Error opening file "%s"\n', flnm);
end
fprintf(fd,s);
fclose(fd);

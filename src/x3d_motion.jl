function x3d_motion(time, lcn, rtn, grp, x3d)
    ## Copyright (C) 2005, Bruce Minaker
    ## This file is intended for use with Octave.
    ## x3d_motion.m is free software; you can redistribute it and/or modify it
    ## under the terms of the GNU General Public License as published by
    ## the Free Software Foundation; either version 2, or (at your option)
    ## any later version.
    ##
    ## x3d_motion.m is distributed in the hope that it will be useful, but
    ## WITHOUT ANY WARRANTY; without even the implied warranty of
    ## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    ## General Public License for more details at www.gnu.org/copyleft/gpl.html.
    ##
    ##--------------------------------------------------------------------

    m = length(time)

    pstn = join([join(string.(lcn[:,i]), " ") for i in 1:m], ",\n")
    rntn = join([join(string.(rtn[:,i]), " ") for i in 1:m], ",\n")
    tme = join(string.(time), ",\n")

s = """
<PositionInterpolator DEF='IDt$(grp)' keyValue='
$(pstn)
' key='
$(tme)
'></PositionInterpolator>
<OrientationInterpolator DEF='IDr$(grp)' keyValue='
$(rntn)
' key='
$(tme)
'></OrientationInterpolator>
<Transform DEF='ID$(grp)' >
$(x3d)</Transform>
<ROUTE fromNode='IDtimer' fromField='fraction_changed' toNode='IDt$(grp)' toField='set_fraction'></ROUTE>
<ROUTE fromNode='IDtimer' fromField='fraction_changed' toNode='IDr$(grp)' toField='set_fraction'></ROUTE>
<ROUTE fromNode='IDt$(grp)' fromField='value_changed' toNode='ID$(grp)' toField='set_translation'></ROUTE>
<ROUTE fromNode='IDr$(grp)' fromField='value_changed' toNode='ID$(grp)' toField='set_rotation'></ROUTE>
"""
    s
end

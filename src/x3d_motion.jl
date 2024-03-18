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

    pstn = ""
    rntn = ""
    scal = ""
    tme = ""

    m = length(time)

    for i in 1:m-1
        pstn *= "$(lcn[1,i]) $(lcn[2,i]) $(lcn[3,i]),\n"
    end
    pstn *= "$(lcn[1,m]) $(lcn[2,m]) $(lcn[3,m])\n"

    for i in 1:m-1
        rntn *= "$(rtn[1,i]) $(rtn[2,i]) $(rtn[3,i]) $(rtn[4,i]),\n"
    end
    rntn *= "$(rtn[1,m]) $(rtn[2,m]) $(rtn[3,m]) $(rtn[4,m])\n"

    for i in 1:m-1
        tme *= "$(time[i]), "
    end
    tme *= "$(time[m])"

    s = "<PositionInterpolator DEF='IDt" * grp * "' keyValue='\n" * pstn * "' key='" * tme * "'></PositionInterpolator>\n"
    s *= "<OrientationInterpolator DEF='IDr" * grp * "' keyValue='\n" * rntn * "' key='" * tme * "'></OrientationInterpolator>\n"

    s *= "<Transform DEF='ID" * grp * "' >\n"
    s *= x3d
    s *= "</Transform>\n"

    s *= "<ROUTE fromNode='IDtimer' fromField='fraction_changed' toNode='IDt" * grp * "' toField='set_fraction'></ROUTE>\n"
    s *= "<ROUTE fromNode='IDtimer' fromField='fraction_changed' toNode='IDr" * grp * "' toField='set_fraction'></ROUTE>\n"
    s *= "<ROUTE fromNode='IDt" * grp * "' fromField='value_changed' toNode='ID" * grp * "' toField='set_translation'></ROUTE>\n"
    s *= "<ROUTE fromNode='IDr" * grp * "' fromField='value_changed' toNode='ID" * grp * "' toField='set_rotation'></ROUTE>\n"

    s
end

module EoM_X3D

import EoM

export animate_modes

include("animate_modes_x3d.jl")
include("eom_draw_x3d.jl")
include("item_locations.jl")
include("x3d_animate.jl")
include("x3d_body.jl")
include("x3d_connections.jl")
include("x3d_cyl.jl")
include("x3d_ifs.jl")
include("x3d_motion.jl")
include("x3d_pnt.jl")
include("x3d_save.jl")

#include(joinpath("tex","tex_bode_pgfplot.jl"))

end

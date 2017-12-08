# This file is a sample to show you how to use EoM to generate the
# equations of motion.  It starts with simple example, the spring
# mass damper.
#
# The first step is to load the EoM library.

using EoM

# The next step is to call the function EoM.input_ex_smd(), which
# contains all the defintions of the spring mass damper system.  One of
# the cool features of Julia is that it allows "keyword arguments",
# i.e., you can pass many arguments to a function, but you can include
# the name of the argument, so it doesn't matter if you mix up the
# order.  The example input file allows you to redefine the values of
# the mass (m), the stiffness (k), and the damping (c).  For example,
# you could call: EoM.input_ex_smd(m=1.2)
# Any values you don't supply just use default defined in the file.

# Now, the twist is that we don't want to call that function directly,
# but instead simply pass that function name onto a helper function
# called run_eom(), which will do some initial processing of the file.
# The problem with that is that we can't pass the name of our
# input function to run_eom() without messing up the arguments that
# we want to send to EoM.input_ex_smd().  To get around this problem,
# we create a temporary function that passes the arguments along to
# our input function, and then give the name of that temporary function
# to run_eom(), along with the values we want to it to send to the input
# function.  The verbose=true flag is optional, to get feedback on the
# progress of run_eom().

temp(i)=EoM.input_ex_smd(m=i)
my_sys=run_eom(temp,1.2,verbose=true)

# Now my_sys holds the processed input file data.  We can now pass this
# along to the equation generator function, again with an optional
# verbose flag.

my_eqns=generate_eom(my_sys,verbose=true)

# At this point, we now have the descriptor state space form of the
# equations of motion of our input system.  To check, we can print one
# of the matrices to the screen.

println(my_eqns[1].A)

# It turns out that my_eqns is a vector, where each entry holds a
# complete set of equations.  In this case, it only has one entry.

# If we want to know more about the behaviour of this system, we can
# do some analysis on the equations.

my_result=analyze(my_eqns,verbose=true)

# We can now print out the eigenvalues of the equations of motion.

println(my_result[1].e_val)

# Just like my_eqns can hold multiple system of equations, my_result can
# generate a result for each entry, and stores it in a vector.  There is
# a handy routine included to write all the interesting results to a
# folder.  The folder is created, and named with a time and date.

folder=write_output(my_sys,my_eqns,my_result,verbose=true)

# The final step is optional, and wraps all the written output into a
# nicely prepared report, using LaTeX

using EoM_TeX
# write_report(folder,my_sys,verbose=true)


using EoM_X3D
animate_modes(folder,my_sys[1],my_result[1])

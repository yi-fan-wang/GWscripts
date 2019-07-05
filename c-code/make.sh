#you include to insert the lallibpath to LD_LIBRARY_PATH by hand

lalpath=/home/astro/Gwaves/lscsoft/opt/master/include
lallibpath=/home/astro/Gwaves/lscsoft/opt/master/lib
cfile=lalsim-nonGR.c

gcc -pthread -I${lalpath} ${cfile} -L${lallibpath} -lm -llal -llalsimulation


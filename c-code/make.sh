#you should include the lallibpath to LD_LIBRARY_PATH by hand

#lalpath=/home/astro/Gwaves/lscsoft/opt/master/include
#lallibpath=/home/astro/Gwaves/lscsoft/opt/master/lib
#cfile=lalsim-nonGR.c
lalpath=/home/astro/Gwaves/lscsoft/opt/mylalfork-cor-tgr/include
lallibpath=/home/astro/Gwaves/lscsoft/opt/mylalfork-cor-tgr/lib
#LD_LIBRARY_PATH=${lallibpath}:LD_LIBRARY_PATH
cfile=lalsim-massivegraviton.c

gcc -pthread -I${lalpath} ${cfile} -L${lallibpath} -lm -llal -llalsimulation


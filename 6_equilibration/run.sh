#!/bin/bash
# sander [-help] [-O] [-A] -i mdin -o mdout -p prmtop -c inpcrd -r restrt
# -ref refc -mtmd mtmd -x mdcrd -y inptraj -v mdvel -frc mdfrc -e mden
# -inf mdinfo -radii radii -cpin cpin -cpout cpout -cprestrt cprestrt
# -evbin evbin -suffix suffix
# -O Overwrite output files if they exist.
# -A Append output files if they exist (used mainly for replica exchange).

pmemd.cuda -O -i equil1.in -p ../common/2agy_final_min.prmtop -ref ../common/2agy_final_min.inpcrd \
              -c ../common/heat6.rst -r equil1.rst  -x equil1.mdcrd -o equil1.out

pmemd.cuda -O -i equil2.in -p ../common/2agy_final_min.prmtop -ref ../common/2agy_final_min.inpcrd \
              -c equil1.rst -r equil2.rst  -x equil2.mdcrd -o equil2.out
           
pmemd.cuda -O -i equil3.in -p ../common/2agy_final_min.prmtop \
              -c equil2.rst -r equil3.rst  -x equil3.mdcrd -o equil3.out
           


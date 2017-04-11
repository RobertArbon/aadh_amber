#!/bin/bash
# sander [-help] [-O] [-A] -i mdin -o mdout -p prmtop -c inpcrd -r restrt
# -ref refc -mtmd mtmd -x mdcrd -y inptraj -v mdvel -frc mdfrc -e mden
# -inf mdinfo -radii radii -cpin cpin -cpout cpout -cprestrt cprestrt
# -evbin evbin -suffix suffix
# -O Overwrite output files if they exist.
# -A Append output files if they exist (used mainly for replica exchange).
for i in {6..7}
do
   sander -O -i cut$i.in -p ../common/2agy_final_min.prmtop \
              -c ../common/equil6.rst -o cut$i.out
done

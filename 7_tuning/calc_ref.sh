#!/bin/bash
# sander [-help] [-O] [-A] -i mdin -o mdout -p prmtop -c inpcrd -r restrt
# -ref refc -mtmd mtmd -x mdcrd -y inptraj -v mdvel -frc mdfrc -e mden
# -inf mdinfo -radii radii -cpin cpin -cpout cpout -cprestrt cprestrt
# -evbin evbin -suffix suffix
# -O Overwrite output files if they exist.
# -A Append output files if they exist (used mainly for replica exchange).

sander -O -i ref.in -p ../common/2agy_final_min.prmtop \
              -c ../common/equil6.rst -o ref.out


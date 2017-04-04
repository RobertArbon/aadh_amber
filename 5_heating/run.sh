#!/bin/bash
# sander [-help] [-O] [-A] -i mdin -o mdout -p prmtop -c inpcrd -r restrt
# -ref refc -mtmd mtmd -x mdcrd -y inptraj -v mdvel -frc mdfrc -e mden
# -inf mdinfo -radii radii -cpin cpin -cpout cpout -cprestrt cprestrt
# -evbin evbin -suffix suffix
# -O Overwrite output files if they exist.
# -A Append output files if they exist (used mainly for replica exchange).

pmemd.cuda -O -i heat1.in -p 2agy_final_min.prmtop -c 2agy_final_min.inpcrd \
          -r heat1.rst  -x heat1.mdcrd -o heat1.out -ref 2agy_final_min.inpcrd
           
pmemd.cuda -O -i heat2.in -p 2agy_final_min.prmtop -c heat1.rst \
          -r heat2.rst  -x heat2.mdcrd -o heat2.out -ref 2agy_final_min.inpcrd

pmemd.cuda -O -i heat3.in -p 2agy_final_min.prmtop -c heat2.rst \
          -r heat3.rst  -x heat3.mdcrd -o heat3.out -ref 2agy_final_min.inpcrd

pmemd.cuda -O -i heat4.in -p 2agy_final_min.prmtop -c heat3.rst \
          -r heat4.rst  -x heat4.mdcrd -o heat4.out -ref 2agy_final_min.inpcrd

pmemd.cuda -O -i heat5.in -p 2agy_final_min.prmtop -c heat4.rst \
          -r heat5.rst  -x heat5.mdcrd -o heat5.out -ref 2agy_final_min.inpcrd

pmemd.cuda -O -i heat6.in -p 2agy_final_min.prmtop -c heat5.rst \
          -r heat6.rst  -x heat6.mdcrd -o heat6.out -ref 2agy_final_min.inpcrd

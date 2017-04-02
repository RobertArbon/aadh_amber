#!/bin/bash

# See http://www.mpibpc.mpg.de/274913/04-Command_line_options_and_parameters


filename=2agy
cp ../common/$filename.psf .
cp ../common/$filename.pdb .
output=water_shell
solvate -t 5 -r 100000.0 -n 15 -s -w $filename $output 

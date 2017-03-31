#!/bin/bash

# See http://www.mpibpc.mpg.de/274913/04-Command_line_options_and_parameters


filename=2agy
cp ../common/$filename.psf .
cp ../common/$filename.pdb .
output=water_shell
solvate -t 7.2 -r 100.0 -n 10 -s -w $filename $output 

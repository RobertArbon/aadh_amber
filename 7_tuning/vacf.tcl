# Calculates velocity auto-correlation function for an atom
set fname '../common/2agy_final_min.prmtop'
set traj 'ref_traj.mdvel'

set mol [mol new $prmtop waitfor all]
mol addnew type netcdf $traj waitfor all

set $sel [atomselect $mol "residue 399 and type HI2"]
set tsteps 100
set dt 0

set nf [molinfo $mol get numframes]
set na [$sel num]

if{$na != 1} {
    puts "Select only one atom"
    quit
}




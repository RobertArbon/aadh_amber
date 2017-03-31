package require solvate

solvate -o wat -minmax {{ -120 -110 -100 } { 120 110 100 }}

mol delete top


mol load psf wat.psf pdb wat.pdb

set sel [atomselect top "all"]
#$sel set segname QQQ
#$sel update
$sel writepdb wat.pdb
$sel writepsf wat.psf





 

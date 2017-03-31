package require autoionize
package require psfgen

set psffile ../common/solvate.psf
set pdbfile ../common/solvate.pdb

autoionize -psf $psffile -pdb $pdbfile -sc 0.15 

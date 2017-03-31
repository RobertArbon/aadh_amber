# Use this script to add extra water around an already solvated protein (e.g. after the use of the other solvat package
# First create a water box in VMD then run this. 

package require psfgen
package require solvate


proc addwater { psffile pdbfile watpsf watpdb } {
    set buffer 12.0
    set overlap 1.2

    # Create psf/pdb files that contain both our protein as well as
    # a box of equilibrated water.  The water box should be large enough
    # to easily contain our protein.
    resetpsf
    readpsf $psffile pdb $pdbfile
    readpsf $watpsf pdb $watpdb

    # Load the combined structure into VMD
    writepsf combine.psf
    writepdb combine.pdb
    mol load psf combine.psf pdb combine.pdb

    # Assume that the segid of the water in watpsf is QQQ
    # We want to delete waters outside of a box ten Angstroms
    # bigger than the extent of the protein.
    # The "protein" is the partially solvated protein
    set prot [atomselect top "protein"]
    set protein [atomselect top {not segid "WT.*"}]


    set minmax [measure minmax $prot]
    foreach {min max} $minmax { break }
    foreach {xmin ymin zmin} $min { break }
    foreach {xmax ymax zmax} $max { break }
        set xmin [expr $xmin - $buffer ]
        set ymin [expr $ymin - $buffer ]
        set zmin [expr $zmin - $buffer ]
        set xmax [expr $xmax + $buffer ]
        set ymax [expr $ymax + $buffer ]
        set zmax [expr $zmax + $buffer ]

    # Center the water on the protein.  Also update the coordinates held
    # by psfgen.
    set wat [atomselect top "not protein"]
    $wat moveby [vecsub [measure center $prot] [measure center $wat]]
    foreach atom [$wat get {segid resid name x y z}] {
        foreach {segid resid name x y z} $atom { break }
        coord $segid $resid $name [list $x $y $z]
    }


    # Get a list of all the residues that are in the outside selection, and delete
    # those residues from the structure.
    # Remove any water (including water not in new box) from the structure 
    set outsidebox [atomselect top "(x <= $xmin or y <= $ymin \
    or z <= $zmin or x >= $xmax or y >= $ymax or z >= $zmax)"]
    foreach segid [$outsidebox get segid] resid [$outsidebox get resid] {
      delatom $segid $resid
    }

    # Get a list of all the residues that are in the overlap selection, and delete
    # those residues from the structure.
    # Assume only possibility of overlap is from new waters i.e. seigd QQQ.
    set badwater [atomselect top "segid \"WT.*\" and within $overlap of (not segid \"WT.*\")"]
    foreach segid [$badwater get segid] resid [$badwater get resid] {
      delatom $segid $resid
    }

    update

    # That should do it - write out the new psf and pdb file.
    writepsf solvate.psf
    writepdb solvate.pdb

    # Delete the combined water/protein molecule and load the system that
    # has excess water removed.
    mol delete top
    mol load psf solvate.psf pdb solvate.pdb

    # Return the size of the water box
    puts [list [list $xmin $ymin $zmin] [list $xmax $ymax $zmax]]
    }



addwater ../common/2agy_ws.psf ../common/2agy_ws.pdb wat.psf wat.pdb 

#Create a different PDB for each chain of the protein:
set molname water_shell  
mol new ${molname}.pdb

proc write_seg { segname } {

    set seg [atomselect top "segname $segname" ] 
    $seg writepdb [concat [string tolower $segname].pdb]

}

set sel [atomselect top all]
set seglist [$sel get segid]
set segs [lsort -unique $seglist]

foreach segid $segs {
  write_seg $segid 
}




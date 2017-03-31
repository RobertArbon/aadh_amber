#Create a different PDB for each chain of the protein:
set molname ionized 
mol new ${molname}.psf
mol addfile ${molname}.pdb
set ctr 1
for {set i 1} {$i < 15} {incr i} {
	set seg [atomselect top [format "segname WT%d" $i]] 

        if {[$seg num] > 0} {
            put [$seg num]
            $seg set segname [format "WT%d" $ctr]
	    $seg writepdb [format "wt%d.pdb" $ctr] 
            incr ctr
}	
	set seg [atomselect top "segname ION" ] 
	$seg writepdb "ion.pdb"  
}

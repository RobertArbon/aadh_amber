#!/bin/bash
mkdir -p backups
for i in {100..105} 
do
    cp w$i.pdb backups/w$i.pdb
    sed -i -e 's/TIP3X/TIP3 /g' w$i.pdb 
done


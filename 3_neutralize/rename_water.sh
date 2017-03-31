#!/bin/bash
for i in {1..27} 
do
    cp wt$i.pdb backups/wt$i.pdb
    sed -i -e 's/TIP3W/TIP3 /g' wt$i.pdb 
done


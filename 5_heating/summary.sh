#!/bin/bash

for i in {1..6}
do 
    summdir=summary$i
    mkdir -p $summdir 
    cd $summdir 
    process_mdout.perl ../heat$i.out
    cd ../
    cat $summdir/summary.TEMP >> summary.TEMP
    cat $summdir/summary.ETOT >> summary.ETOT
    cat $summdir/summary.EKTOT >> summary.EKTOT
    cat $summdir/summary.EPTOT >> summary.EPTOT
done

    

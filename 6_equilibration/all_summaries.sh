#!/bin/bash
fname=equil
for i in {1..3}
do 
    summdir=summary$i
    mkdir -p $summdir 
    cd $summdir 
    process_mdout.perl ../$fname$i.out
    cd ../
    cat $summdir/summary.TEMP >> summary.TEMP
    cat $summdir/summary.ETOT >> summary.ETOT
    cat $summdir/summary.EKTOT >> summary.EKTOT
    cat $summdir/summary.EPTOT >> summary.EPTOT
    cat $summdir/summary.DENSITY >> summary.DENSITY
    cat $summdir/summary.VOLUME >> summary.VOLUME
done

    

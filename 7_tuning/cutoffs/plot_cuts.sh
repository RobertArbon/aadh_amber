#!/bin/bash

for i in {6..12}
do
    echo $i, `sed -n 272p cut$i.out | awk '{print $5}'` >> cut_vs_rms.out
    echo $i, `sed -n 265p cut$i.out | awk '{print $5}'` >> cut_vs_abs.out
done

#!/bin/bash

export NEMO_DIR=/gws/nopw/j04/nemo_vol1/ORCA0083-N006/means
export DATA_DIR=/gws/nopw/j04/nemo_vol5/jdha/ARIANE_example/Data

cd $NEMO_DIR

for grd in T U V W; do 
  n=1
  for y in {2000..2009}; do 
    cd $y
    for fn in *d05$grd\.nc; do 
      nstr=`printf %3.3i $n`
      ln -s $NEMO_DIR/$y/$fn $DATA_DIR/ORCA0083-N006_$nstr$grd\.nc
      n=$((n + 1))
    done
    cd ../
  done
done

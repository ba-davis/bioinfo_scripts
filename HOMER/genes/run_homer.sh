#!/bin/bash

#dir="./input"
dir="./input/sep"

for file in $dir/*.txt; do

    name=${file##*/}
    dirname=${name##*/}
    outdir="${dirname%.*}"

    mkdir $outdir

    findMotifs.pl $file mouse $outdir
done

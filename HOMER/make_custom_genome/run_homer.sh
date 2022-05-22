#!/bin/bash

file=/home/groups/hoolock2/u0/bd/Projects/ECP55/data/homer/input/sig_genes.txt
outdir=homer_out
findMotifs.pl $file xenLae2 $outdir

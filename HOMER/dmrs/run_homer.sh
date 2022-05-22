#!/bin/bash

infile1='./input/v2/IL1b_vs_veh_KO_p0.05.all.bed'
infile2='./input/v2/IL1b_vs_veh_KO_p0.05.hyper.bed'
infile3='./input/v2/IL1b_vs_veh_KO_p0.05.hypo.bed'
infile4='./input/v2/IL1b_vs_veh_WT_p0.05.all.bed'
infile5='./input/v2/IL1b_vs_veh_WT_p0.05.hyper.bed'
infile6='./input/v2/IL1b_vs_veh_WT_p0.05.hypo.bed'
infile7='./input/v2/KO_vs_WT_IL1b_p0.05.all.bed'
infile8='./input/v2/KO_vs_WT_IL1b_p0.05.hyper.bed'
infile9='./input/v2/KO_vs_WT_IL1b_p0.05.hypo.bed'
infile10='./input/v2/KO_vs_WT_veh_p0.05.all.bed'
infile11='./input/v2/KO_vs_WT_veh_p0.05.hyper.bed'
infile12='./input/v2/KO_vs_WT_veh_p0.05.hypo.bed'

genome_path='/home/groups/hoolock2/u0/genomes/ensembl/mus_musculus/Mus_musculus.GRCm38.dna.primary_assembly.fa'

findMotifsGenome.pl $infile1 $genome_path ./IL1b_vs_veh_KO_p0.05.all -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile2 $genome_path ./IL1b_vs_veh_KO_p0.05.hyper -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile3 $genome_path ./IL1b_vs_veh_KO_p0.05.hypo -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile4 $genome_path ./IL1b_vs_veh_WT_p0.05.all -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile5 $genome_path ./IL1b_vs_veh_WT_p0.05.hyper -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile6 $genome_path ./IL1b_vs_veh_WT_p0.05.hypo -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile7 $genome_path ./KO_vs_WT_IL1b_p0.05.all -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile8 $genome_path ./KO_vs_WT_IL1b_p0.05.hyper -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile9 $genome_path ./KO_vs_WT_IL1b_p0.05.hypo -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile10 $genome_path ./KO_vs_WT_veh_p0.05.all -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile11 $genome_path ./KO_vs_WT_veh_p0.05.hyper -size given -len 8,10,12 -p 8

findMotifsGenome.pl $infile12 $genome_path ./KO_vs_WT_veh_p0.05.hypo -size given -len 8,10,12 -p 8

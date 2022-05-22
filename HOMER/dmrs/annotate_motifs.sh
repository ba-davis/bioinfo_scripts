#!/bin/bash

# first, concatenate all the .motif fules in the knownResults directory into one .motif file
# cat *.motif > knownResults.all.motif

genome_path='/home/groups/hoolock2/u0/genomes/ensembl/mus_musculus/Mus_musculus.GRCm38.dna.primary_assembly.fa'

infile='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/input/v2/IL1b_vs_veh_KO_p0.05.all.bed'
motif_file='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/IL1b_vs_veh_KO_p0.05.all/knownResults/knownResults.all.motif'
annotatePeaks.pl $infile $genome_path -size given -m $motif_file > IL1b_vs_veh_KO_p0.05.all.annot.output.txt

infile='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/input/v2/IL1b_vs_veh_KO_p0.05.hyper.bed'
motif_file='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/IL1b_vs_veh_KO_p0.05.hyper/knownResults/knownResults.all.motif'
annotatePeaks.pl $infile $genome_path -size given -m $motif_file > IL1b_vs_veh_KO_p0.05.hyper.annot.output.txt

infile='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/input/v2/IL1b_vs_veh_KO_p0.05.hypo.bed'
motif_file='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/IL1b_vs_veh_KO_p0.05.hypo/knownResults/knownResults.all.motif'
annotatePeaks.pl $infile $genome_path -size given -m $motif_file > IL1b_vs_veh_KO_p0.05.hypo.annot.output.txt

infile='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/input/v2/IL1b_vs_veh_WT_p0.05.all.bed'
motif_file='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/IL1b_vs_veh_WT_p0.05.all/knownResults/knownResults.all.motif'
annotatePeaks.pl $infile $genome_path -size given -m $motif_file > IL1b_vs_veh_WT_p0.05.all.annot.output.txt

infile='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/input/v2/IL1b_vs_veh_WT_p0.05.hyper.bed'
motif_file='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/IL1b_vs_veh_WT_p0.05.hyper/knownResults/knownResults.all.motif'
annotatePeaks.pl $infile $genome_path -size given -m $motif_file > IL1b_vs_veh_WT_p0.05.hyper.annot.output.txt

infile='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/input/v2/IL1b_vs_veh_WT_p0.05.hypo.bed'
motif_file='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/IL1b_vs_veh_WT_p0.05.hypo/knownResults/knownResults.all.motif'
annotatePeaks.pl $infile $genome_path -size given -m $motif_file > IL1b_vs_veh_WT_p0.05.hypo.annot.output.txt

infile='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/input/v2/KO_vs_WT_IL1b_p0.05.all.bed'
motif_file='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/KO_vs_WT_IL1b_p0.05.all/knownResults/knownResults.all.motif'
annotatePeaks.pl $infile $genome_path -size given -m $motif_file > KO_vs_WT_IL1b_p0.05.all.annot.output.txt

infile='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/input/v2/KO_vs_WT_IL1b_p0.05.hyper.bed'
motif_file='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/KO_vs_WT_IL1b_p0.05.hyper/knownResults/knownResults.all.motif'
annotatePeaks.pl $infile $genome_path -size given -m $motif_file > KO_vs_WT_IL1b_p0.05.hyper.annot.output.txt

infile='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/input/v2/KO_vs_WT_IL1b_p0.05.hypo.bed'
motif_file='/home/groups/hoolock2/u0/bd/Projects/agarwal/TET2_Project/john_mcclatchy_projs/lks_homer/dmrs/KO_vs_WT_IL1b_p0.05.hypo/knownResults/knownResults.all.motif'
annotatePeaks.pl $infile $genome_path -size given -m $motif_file > KO_vs_WT_IL1b_p0.05.hypo.annot.output.txt

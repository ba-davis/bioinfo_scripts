#!/bin/bash

# activate java
#conda activate /home/groups/hoolock2/u0/bd/bin/miniconda3/envs/ATACseq
#export FONTCONFIG_PATH=/etc/fonts


#-----------------------#
# INPUT VARIABLES
#-----------------------#
# inpath to shorten path to input files
input_dir="/home/groups/hoolock2/u0/bd/Projects/agarwal/mona_nanostring/gsea/data"
# counts table
exp_dat=$input_dir/nanostring_data.txt
# phenotype cls file
cls_file=$input_dir/nanostring_phenotypes.cls
# full path to location of output directory to create
outdir="/home/groups/hoolock2/u0/bd/Projects/agarwal/mona_nanostring/gsea/test"

#-----------------------#

mkdir -p $outdir

# Hallmark
gmt_file="/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/gmt_files/h.all.v7.1.symbols.gmt"
gene_set="Hallmark"
mkdir $outdir/$gene_set

# Run GSEA
java -Xmx16g -cp /home/users/davibr/bin/gsea-3.0.jar xtools.gsea.Gsea \
     -gmx $gmt_file \
     -nperm 1000 \
     -scoring_scheme weighted \
     -norm meandiv \
     -res $exp_dat \
     -cls $cls_file \
     -permute gene_set \
     -collapse false \
     -set_max 5000 \
     -set_min 15 \
     -plot_top_x 20 \
     -out $outdir/$gene_set \
     -gui false > $outdir/$gene_set/run_log.txt

# TFT
gmt_file="/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/gmt_files/c3.tft.v7.1.symbols.gmt"
gene_set="TFT"
mkdir $outdir/$gene_set

# Run GSEA
java -Xmx16g -cp /home/users/davibr/bin/gsea-3.0.jar xtools.gsea.Gsea \
     -gmx $gmt_file \
     -nperm 1000 \
     -scoring_scheme weighted \
     -norm meandiv \
     -res $exp_dat \
     -cls $cls_file \
     -permute gene_set \
     -collapse false \
     -set_max 5000 \
     -set_min 15 \
     -plot_top_x 20 \
     -out $outdir/$gene_set \
     -gui false > $outdir/$gene_set/run_log.txt

# C5
gmt_file="/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/gmt_files/c5.all.v7.2.symbols.gmt"
gene_set="C5"
mkdir $outdir/$gene_set

# Run GSEA
java -Xmx16g -cp /home/users/davibr/bin/gsea-3.0.jar xtools.gsea.Gsea \
     -gmx $gmt_file \
     -nperm 1000 \
     -scoring_scheme weighted \
     -norm meandiv \
     -res $exp_dat \
     -cls $cls_file \
     -permute gene_set \
     -collapse false \
     -set_max 5000 \
     -set_min 15 \
     -plot_top_x 20 \
     -out $outdir/$gene_set \
     -gui false > $outdir/$gene_set/run_log.txt

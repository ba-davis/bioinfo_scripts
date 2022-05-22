#!/bin/bash

# activate java
#conda activate /home/groups/hoolock2/u0/bd/bin/miniconda3/envs/ATACseq
#export FONTCONFIG_PATH=/etc/fonts

# Execute from within the project GSEA directory (with a rnk_files directory)

# path to rnk files
dir=/home/groups/hoolock2/u0/bd/Projects/agarwal/runx1_project_LPS_data/gsea/LPS_HD/rnk_files/tmp

for file in $dir/*.rnk; do
    name=${file##*/}
    echo $name
    newdir="${name%.*}"
    echo $newdir
    rnk_file=$file
    echo $rnk_file
    
    # Hallmark
    gmt_file="/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/gmt_files/h.all.v7.1.symbols.gmt"
    gene_set="Hallmark"
    outdir=$newdir
    mkdir -p $outdir
    mkdir $outdir/$gene_set
    # Run GSEA PreRanked
    java -Xmx16g -cp /home/users/davibr/bin/gsea-3.0.jar xtools.gsea.GseaPreranked \
	 -rnk $rnk_file \
	 -gmx $gmt_file \
	 -collapse false \
	 -nperm 1000 \
	 -scoring_scheme weighted \
	 -set_max 5000 \
	 -set_min 15 \
	 --plot_top_x 100 \
	 -out $outdir/$gene_set \
	 -gui false > $outdir/$gene_set/run_log.txt

    # Oncogenic
    gmt_file="/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/gmt_files/c6.all.v7.1.symbols.gmt"
    gene_set="Oncogenic"
    mkdir $outdir/$gene_set
    # Run GSEA PreRanked
    java -Xmx16g -cp /home/users/davibr/bin/gsea-3.0.jar xtools.gsea.GseaPreranked \
         -rnk $rnk_file \
         -gmx $gmt_file \
         -collapse false \
         -nperm 1000 \
         -scoring_scheme weighted \
         -set_max 5000 \
         -set_min 15 \
         --plot_top_x 100 \
         -out $outdir/$gene_set \
         -gui false > $outdir/$gene_set/run_log.txt

    # TFT
    gmt_file="/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/gmt_files/c3.tft.v7.1.symbols.gmt"
    gene_set="TFT"
    mkdir $outdir/$gene_set
    # Run GSEA PreRanked
    java -Xmx16g -cp /home/users/davibr/bin/gsea-3.0.jar xtools.gsea.GseaPreranked \
         -rnk $rnk_file \
         -gmx $gmt_file \
         -collapse false \
         -nperm 1000 \
         -scoring_scheme weighted \
         -set_max 5000 \
         -set_min 15 \
         --plot_top_x 100 \
         -out $outdir/$gene_set \
         -gui false > $outdir/$gene_set/run_log.txt

    # C5
    gmt_file="/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/gmt_files/c5.all.v7.2.symbols.gmt"
    gene_set="C5"
    mkdir $outdir/$gene_set
    # Run GSEA PreRanked
    java -Xmx16g -cp /home/users/davibr/bin/gsea-3.0.jar xtools.gsea.GseaPreranked \
         -rnk $rnk_file \
         -gmx $gmt_file \
         -collapse false \
         -nperm 1000 \
         -scoring_scheme weighted \
         -set_max 5000 \
         -set_min 15 \
         --plot_top_x 100 \
         -out $outdir/$gene_set \
         -gui false > $outdir/$gene_set/run_log.txt
    
    # C2
    gmt_file="/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/gmt_files/c2.all.v7.4.symbols.gmt"
    gene_set="C2"
    mkdir $outdir/$gene_set
    # Run GSEA PreRanked
    java -Xmx16g -cp /home/users/davibr/bin/gsea-3.0.jar xtools.gsea.GseaPreranked \
	 -rnk $rnk_file \
	 -gmx $gmt_file \
	 -collapse false \
	 -nperm 1000 \
	 -scoring_scheme weighted \
	 -set_max 5000 \
	 -set_min 15 \
	 --plot_top_x 100 \
	 -out $outdir/$gene_set \
	 -gui false > $outdir/$gene_set/run_log.txt

    # C3
    #gmt_file="/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/gmt_files/c3.tft.v7.1.symbols.gmt"
    #gene_set="C3"
    #mkdir $outdir/$gene_set
    # Run GSEA PreRanked
    #java -Xmx16g -cp /home/users/davibr/bin/gsea-3.0.jar xtools.gsea.GseaPreranked \
#	 -rnk $rnk_file \
#	 -gmx $gmt_file \
#	 -collapse false \
#	 -nperm 1000 \
#	 -scoring_scheme weighted \
#	 -set_max 5000 \
#	 -set_min 15 \
#	 -out $outdir/$gene_set \
#	 -gui false > $outdir/$gene_set/run_log.txt
    
    # C6
    #gmt_file="/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/gmt_files/c6.all.v7.1.symbols.gmt"
    #gene_set="Oncogenic"
    #mkdir $outdir/$gene_set
    # Run GSEA PreRanked
    #java -Xmx16g -cp /home/users/davibr/bin/gsea-3.0.jar xtools.gsea.GseaPreranked \
#	 -rnk $rnk_file \
#	 -gmx $gmt_file \
#	 -collapse false \
#	 -nperm 1000 \
#	 -scoring_scheme weighted \
#	 -set_max 5000 \
#	 -set_min 15 \
#	 -out $outdir/$gene_set \
#	 -gui false > $outdir/$gene_set/run_log.txt
done

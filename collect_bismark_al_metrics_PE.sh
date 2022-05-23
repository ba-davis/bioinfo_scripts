#!/bin/bash

# Purpose: Use the *_bismark_bt2_PE_report.txt files to collect
#          bismark alignment stats per file/sample
#          For PE files, the "R1" file name is used

# Input variables:
#   - inpath: path to folder containing bismark alignment stats


inpath=$1

#----------------------------------#
# Get Stats from Bismark Alignment #
#----------------------------------#

cd $inpath
for i in $inpath/*_bismark_bt2_PE_report.txt; do
    filename=$i
    # get fastq file name (R1) (excluded the fastq.gz extension, goes to "R1_001"
    grep -l "Bismark completed" $filename | sed -e 's/_val_1_bismark_bt2_PE_report.txt//g' | sed -e "s|$inpath||g" | sed -e 's/\///g' >> tmp_file_name

    # get sequence pairs analyzed
    grep "Sequence pairs analysed in total" $filename | cut -f2 >> tmp_seq_pairs

    # get unique alignment number
    grep "Number of paired-end alignments with a unique best hit" $filename | cut -f2 >> tmp_unq_aln

    # get mapping efficiency
    grep "Mapping efficiency:" $filename | cut -f2 >> tmp_mapping

    # get seq pairs with no alignments
    grep "Sequence pairs with no alignments under any condition:" $filename | cut -f2 >> tmp_no_aln

    # get multimappers
    grep "Sequence pairs did not map uniquely:" $filename | cut -f2 >> tmp_multimap

    # get seq pairs discarded due to genomic sequence not extracted
    grep "Sequence pairs which were discarded because genomic sequence could not be extracted:" $filename | cut -f2 >> tmp_discarded

    # get total C's analyzed
    grep "Total number of C's analysed:" $filename | cut -f2 >> tmp_total_c

    # get c methylated in CpG context
    grep "C methylated in CpG context:" $filename | cut -f2 >> tmp_cpg

    # get c methylated in CHG context
    grep "C methylated in CHG context:" $filename | cut -f2 >> tmp_chg

    # get c methylated in CHH context
    grep "C methylated in CHH context:" $filename | cut -f2 >> tmp_chh

    # get c meethylated in unknown context
    grep "C methylated in unknown context" $filename | cut -f2 >> tmp_unknown
done

paste -d "\t" tmp_file_name tmp_seq_pairs tmp_unq_aln tmp_mapping tmp_no_aln tmp_multimap tmp_discarded tmp_total_c tmp_cpg tmp_chg tmp_chh tmp_unknown > tmp_bismark_stats.tmp.txt
sort tmp_bismark_stats.tmp.txt > bismark_stats.txt

sed -i '1 i\Fastq_File\tInputReadPairs\tUniqueAln\tMappingEfficiency\tNoAln\tMultimapped\tDiscarded\tTotal_Cs_Analyzed\tCpG_Meth\tCHG_meth\tCHH_meth\tUnknown_meth' bismark_stats.txt
rm tmp_*

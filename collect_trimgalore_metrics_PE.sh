#!/bin/bash

# Purpose: Use the TrimGalore *_trimming_report.txt files to collect
#          trimming stats per file/sample.
#          For PE reads, use the *R2*_trimming_report.txt files

# Input variables:
#   - inpath: path to folder containing trimgalore output
#             specifically, need the *_trimming_report.txt files
#   -
inpath=$1

#---------------------------#
# Get Stats from TrimGalore #
#---------------------------#

cd $inpath
for i in $inpath/*R2*_trimming_report.txt; do
    filename=$i
    # get fastq file name (R2)
    grep -l "RUN STATISTICS FOR INPUT FILE:" $filename | sed -e 's/_trimming_report.txt//g' | sed -e "s|$inpath||g" | sed -e 's/\///g' >> tmp_r2_file_name

    # get number of seuences processed in total
    grep "sequences processed in total" $filename | cut -d " " -f1 >> tmp_sequences

    # get number of sequences used for seq pair length validation
    grep "for the sequence pair length validation" $filename | cut -d " " -f12 >> tmp_seq_val

    # get number of pairs removed due to length cutoff
    grep "Number of sequence pairs removed" $filename | cut -d " " -f19 >> tmp_pairs_rm_number

    # get percent of pairs removed due to length cutoff
    grep "Number of sequence pairs removed" $filename | cut -d " " -f20 | tr -d '()' >> tmp_pairs_rm_percent
done

paste -d "\t" tmp_r2_file_name tmp_sequences tmp_seq_val tmp_pairs_rm_number tmp_pairs_rm_percent > tmp_trimgalore_stats.tmp.txt
sort tmp_trimgalore_stats.tmp.txt > trimgalore_stats.txt

sed -i '1 i\Fastq_File\tInputReadPairs\tPairsUsedForPairLengthValid\tPairsRemoved\tPairsRemovedPercent' trimgalore_stats.txt

rm tmp_*

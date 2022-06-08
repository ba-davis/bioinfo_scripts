#!/bin/bash

# For SE data
# usage: ./my_calc_mito.sh file.sorted.bam basename


# Get number of reads (not alignments) in bam file
total_reads=$(samtools view -F 0x904 -c $1)

# Remove mitochondrial reads from alignment file
samtools idxstats $1 \
 | cut -f 1 \
 | grep -v MT \
 | xargs samtools view -b $1 > $1.noMT.bam

# Get number of reads in noMT bam file
noMT_reads=$(samtools view -F 0x904 -c $1.noMT.bam)

# Calculate percent of MT reads
#percent=(($total_reads - $noMT_reads) / $total_reads) * 100

echo $1
echo $total_reads
echo $noMT_reads

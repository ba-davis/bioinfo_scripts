#!/bin/bash

#### Calculate percentage of reads mapped to mitochondrial genome (mtDNA) using SAMtools idxstats
#### Can be useful for ATAC-seq data. Requires an indexed BAM file:

# Change to "ChrM" or "MT" depending on reference genome format

## Check if index is present. If not, create it:
if [[ ! -e ${1}.bai ]];
  then
  echo '[INFO]: File does not seem to be indexed. Indexing now:'
  samtools index $i
  fi

## Calculate %mtDNA:
mtReads=$(samtools idxstats $1 | grep 'MT' | cut -f 3)
totalReads=$(samtools idxstats $1 | awk '{SUM += $3} END {print SUM}')

echo $mtReads
echo $totalReads
echo '==> mtDNA Content:' $(bc <<< "scale=2;100*$mtReads/$totalReads")'%'

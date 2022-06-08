#!/bin/bash

for i in $(find ./ -type f -name "*.fastq.gz" | while read F; do basename $F | rev | cut -c 29- | rev; done | sort | uniq)

    do echo "Merging R1"
   
       echo $i
       
cat "$i"_L00*_R1_001.trim12.fastq.gz > merged/"$i"_ME_R1_001.fastq.gz

#       echo "Merging R2"

#cat "$i"_L00*_R2_001.fastq.gz > "$i"_ME_L001_R2_001.fastq.gz

done;

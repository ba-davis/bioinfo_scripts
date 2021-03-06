#!/bin/bash

# Get the lengths of the chromosomes given the header in a .bam file

samtools view -H $1 | \
  grep "SN" |
  awk 'BEGIN{OFS="\t"} {print $2, $3}' | \
  sed 's/SN://' | \
  sed 's/LN://' 

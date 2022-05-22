#!/bin/bash

# Generate a custom genome for homer with given fasta genome file and gtf file

#fasta_file=/home/groups/hoolock2/u0/genomes/ucsc/xenLae2/xenLae2.fa
#gtf_file=/home/groups/hoolock2/u0/genomes/ucsc/xenLae2/annotation/xenbase/XENLA_9.2_Xenbase.gtf

#loadGenome.pl -name xenLae2 -org xen_laevis -fasta $fasta_file -gtf $gtf_file -gid

#--------------------------------#

# Generate promoters from the above custom genome for homer

tss_file=/home/groups/hoolock2/u0/bd/bin/homer/data/genomes/xenLae2/xenLae2.tss
loadPromoters.pl -name xenLae2 -org xen_laevis -id custom -genome xenLae2 -tss $tss_file

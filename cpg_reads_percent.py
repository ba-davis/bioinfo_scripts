#!/usr/bin/python

# RRBS Digestion Efficiency 
# 
# RRBS involves a restriction digest to enrich for reads beginning with "CG"
# After bisulfite conversion, unmethylated C's will be sequenced as T's
#
# PURPOSE: Determine the percent of reads from a sample that begin with: "CGG", "TGG", "CAA", "NGG", "N" 
#
# PARAMETERS (REQUIRED): -d : path to directory of gzipped fastq files (ending in .gz)
#                        -o : name of output file
#
# Given a directory of gzipped fastq files, determine the percent of reads that begin with
#  "CGG" or "TGG" or "CAA" in each file and output the info to an output file.
#
# "correct reads" = reads that begin with CG or TG
#
# Output file format: <File_Name> <Total Number of Reads> <Number of correct reads> <Percent of correct reads>


import gzip
import glob
from os.path import basename
import optparse

# Initialize command line options for input directory and output file
p=optparse.OptionParser()
p.add_option("-d", action = "store", dest = "directory")
p.add_option("-o", action = "store", dest = "outfile")
opts,args=p.parse_args()
directory=opts.directory
outfile=opts.outfile

fhw = open(outfile, "w+") # open the output file and allow it to be written to

# parse each file in the input directory
for infile in glob.glob(directory + '/*.gz'):
    name = basename(infile) # grab the file name
    print "Reading %s" % (name)
    fh=gzip.open(infile, "r")   # open the gzipped file for reading

    linecount=0 # initialize linecount variable to count number of lines in the file
    CGG_count=0 # initialize variable to count the number of lines that begin with CGG
    TGG_count=0 # initialize variable to count the number of lines that begin with TGG
    CAA_count=0 # initialize variable to count the number of lines that begin with CAA
    N_count=0   # initialize variable to count the number of lines that begin with N
    NGG_count=0 # initialize variable to count the number of lines that begin with NGG

    # parse infile to determine number of sequences that start with various bases
    for line in fh:
        line=line.strip('\n')
        linecount += 1
        if linecount % 4 == 2:
            if list(line)[0] == "C" and list(line)[1] == "G" and list(line)[2] == "G":
                CGG_count += 1
            elif list(line)[0] == "T" and list(line)[1] == "G" and list(line)[2] == "G":
                TGG_count += 1
            elif list(line)[0] == "C" and list(line)[1] == "A" and list(line)[2] == "A":
                CAA_count += 1
            elif list(line)[0] == "N" and list(line)[1] == "G" and list(line)[2] == "G":
                NGG_count += 1
            elif list(line)[0] == "N":
                N_count += 1
    total_seq = linecount / 4 
    #percent_correct = (float(yes_count) / float(total_seq)) * 100
    cgg_percent = (float(CGG_count) / float(total_seq)) * 100
    tgg_percent = (float(TGG_count) / float(total_seq))* 100
    caa_percent = (float(CAA_count) / float(total_seq))* 100
    ngg_percent = (float(NGG_count) / float(total_seq))* 100
    n_percent = (float(N_count) / float(total_seq))* 100
    fhw.write("%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % (name, total_seq, cgg_percent, tgg_percent, caa_percent, n_percent, ngg_percent))

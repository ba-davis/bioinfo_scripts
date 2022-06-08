#!/usr/bin/python

# remove the first x bases from each read in a fastq file

# used for Tag-seq which recommends removing the first 12 bases

# INPUT:  -i: fastq.gz file
#         -n: number of bases to remove off the front
# OUTPUT: -o: desired outfile name (ending in .fastq.gz)

import re
import optparse
import gzip

p=optparse.OptionParser()
p.add_option("-i", action = "store", dest = "infile")
p.add_option("-n", action = "store", dest = "num")
p.add_option("-o", action = "store", dest = "outfile")
opts,args=p.parse_args()
infile=opts.infile
num=int(opts.num)
outfile=opts.outfile

fh=gzip.open(infile, "r")
fhw=gzip.open(outfile, "w+")

linecount=0

for line in fh:
    line=line.strip('\n')
    linecount += 1
    if linecount % 4 == 1:
        fhw.write(line + '\n')
    if linecount % 4 == 2:
        my_line = list(line)
        newline = my_line[num:]
        new = ''.join(newline)
        fhw.write(new + '\n')
    if linecount % 4 == 3:
        fhw.write("+" + '\n')
    if linecount % 4 == 0:
        my_line = list(line)
        newline = my_line[num:]
        new = ''.join(newline)
        fhw.write(new + '\n')

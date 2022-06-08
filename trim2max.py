#!/usr/bin/python

# remove trailing bases from the end of reads for a desired max length

# INPUT:  -i: fastq.gz file
#         -l: desired max length
# OUTPUT: -o: desired outfile name (ending in .fastq.gz)


import re
import optparse
import gzip

p=optparse.OptionParser()
p.add_option("-i", action = "store", dest = "infile")
p.add_option("-l", action = "store", dest = "length")
p.add_option("-o", action = "store", dest = "outfile")
opts,args=p.parse_args()
infile=opts.infile
length=opts.length
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
        my_length = len(my_line)
        foo = my_length - int(length)
        if foo > 0:
            sub = my_line[:-foo]
            new = ''.join(sub) 
            fhw.write(new + '\n')
        elif foo <= 0:
            fhw.write(line + '\n')
    if linecount % 4 == 3:
        fhw.write("+" + '\n')
    if linecount % 4 == 0:
        my_line = list(line)
        my_length = len(my_line)
        foo = my_length - int(length)
        if foo > 0:
            sub = my_line[:-foo]
            new = ''.join(sub)
            fhw.write(new + '\n')
        elif foo <= 0:
            fhw.write(line + '\n')

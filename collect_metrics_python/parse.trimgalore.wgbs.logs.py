#!/home/groups/hoolock2/u0/bd/miniconda3/envs/python3_general/bin/python

#----------------------------------------------------------------------------------------------------------------#
# Purpose: to parse relevant info from a directory of TrimGalore WGBS log files                                  #
#          and produce an outfile containing a table of trimming stats per sample                                #
#                                                                                                                #
# Useage: ./parse.trimgalore.logs.py -d /path/to/trimming/reports -o path/to/outfile                             #
#----------------------------------------------------------------------------------------------------------------#

# Notes:
#        - Currently set up for PE WGBS TrimGalore reports

# TODO: - Make a RRBS option or a separate RRBS TrimGalore script
#       - Make a SE option or a separate SE script


# Import Libraries
import optparse
import pandas as pd
import re
import os


# Initialize command line options for input directory and output file
p=optparse.OptionParser()
p.add_option("-d", action = "store", dest = "directory")
p.add_option("-o", action = "store", dest = "outfile")

opts,args=p.parse_args()
in_dir=opts.directory
outfile=opts.outfile

# open outfile for writing
fhw = open(outfile, "w+")
# write colnames to outfile
fhw.write('Fastq_File' + '\t' + 'Seqs_Processed' + '\t' + 'Seqs_Pair_Validated' + '\t' + 'Seqs_Rm' + '\t' + 'Seqs_Rm_Perc' + '\n')

# for file ending in 'trimming_report.txt' in directory
for file in os.listdir(in_dir):
    filename = os.fsdecode(file)
    if filename.endswith("trimming_report.txt"):
        path_file=in_dir + '/' + filename
        theFile = open(path_file,'r')
        FILE = theFile.readlines()
        theFile.close()
        printList = []
        if len(list(filter(lambda x: re.search(r'Number of sequence pairs removed', x), FILE))) > 0:
            for line in FILE:
                if ('RUN STATISTICS FOR INPUT FILE' in line):
                    intname=line.split('/')[-1].rstrip()
                    printList.append(intname + '\t')
                if ('sequences processed in total' in line):
                    intname=line.split(' ')[0]
                    printList.append(intname + '\t')
                if ('sequence pair length validation' in line):
                    intname=line.split(' ')[-1].rstrip()
                    printList.append(intname + '\t')
                if ('sequence pairs removed' in line):
                    intname=line.split(' ')[-2].rstrip()
                    printList.append(intname + '\t')
                if ('sequence pairs removed' in line):
                    intname=line.split(' ')[-1].rstrip()
                    intname2=intname.replace('(','')
                    intname3=intname2.replace(')', '')
                    printList.append(intname3 + '\n')
            for item in printList:
                fhw.write(item)
        else:
            continue
    else:
        continue

fhw.close()

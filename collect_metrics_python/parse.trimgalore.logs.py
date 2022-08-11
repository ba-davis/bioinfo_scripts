#!/home/groups/hoolock/u1/bd/bin/miniconda3/bin/python

#----------------------------------------------------------------------------------------------------------------#
# Purpose: to parse relevant info from a directory of trimmomatic log files                                      #
#          and produce an outfile containing a table of trimming stats per sample                                #
#                                                                                                                #
# Useage: ./parse.trimgalore.logs.py -d /path/to/trimming/reports -o path/to/outfile                             #
#----------------------------------------------------------------------------------------------------------------#

import optparse
import pandas as pd
import re
import os


# Initialize command line options for input directory and output file
p=optparse.OptionParser()
p.add_option("-d", action = "store", dest = "directory")
p.add_option("-o", action = "store", dest = "outfile")
#p.add_option("-t", action = "store", dest = "trimming")

opts,args=p.parse_args()
in_dir=opts.directory
outfile=opts.outfile
#trimming_path=opts.trimming

# open outfile for writing
fhw = open(outfile, "w+")
# write colnames to outfile
fhw.write('Sample' + '\t' + 'Input_Reads' + '\t' + 'Reads_Trimmed_Phred' + '\t' + 'Reads_Removed' + '\t' + 'RRBS_Reads_Trimmed' + '\n')

# for file ending in '.txt' in directory
for file in os.listdir(in_dir):
    filename = os.fsdecode(file)
    if filename.endswith(".txt"):
        # read in the file as a pandas df
        path_file=in_dir + '/' + filename
        df = pd.read_table(path_file, skiprows=range(0,153), skipfooter=1, sep='delimeter', engine='python')

        # grab the sample name from the log file name
        sample = re.sub('.fastq.gz_trimming_report.txt', '', filename)
        
        # grab the number of input reads from first row
        input_reads = df.iat[0,0]
        input_reads = re.sub(' sequences processed in total', '', input_reads)

        # grab the trimmed reads number
        trimmed_reads = df.iat[1,0]
        # split this string on a tab delimiter, and select the 2nd entry (1)
        trimmed_reads = trimmed_reads.split('\t')[1]

        # grab the dropped reads number
        dropped_reads = df.iat[2,0]
        # split this string on a tab delimiter, and select the 2nd entry (1)
        dropped_reads = dropped_reads.split('\t')[1]

        # grab the RRBS trimmed reads number
        rrbs_reads = df.iat[3,0]
        # split this string on a tab delimiter, and select the 2nd entry (1)
        rrbs_reads = rrbs_reads.split('\t')[1]

        # write to outfile
        fhw.write(sample + '\t' + input_reads + '\t' + trimmed_reads + '\t' + dropped_reads + '\t' + rrbs_reads + '\n')
        
    else:
        continue

fhw.close()

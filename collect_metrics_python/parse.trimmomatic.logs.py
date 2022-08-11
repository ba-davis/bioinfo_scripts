#!/home/groups/hoolock/u1/bd/bin/miniconda3/bin/python

#----------------------------------------------------------------------------------------------------------------#
# Purpose: to parse relevant info from a directory of trimmomatic log files                                      #
#          and produce an outfile containing a table of trimming stats per sample                                #
#                                                                                                                #
# Useage: ./parse.trimmomatic.logs.py -d /path/to/trimming/reports -o path/to/outfile -t path/to/trimmed/fastqs  #
#----------------------------------------------------------------------------------------------------------------#

import optparse
import pandas as pd
import re
import os


# Initialize command line options for input directory and output file
p=optparse.OptionParser()
p.add_option("-d", action = "store", dest = "directory")
p.add_option("-o", action = "store", dest = "outfile")
p.add_option("-t", action = "store", dest = "trimming")

opts,args=p.parse_args()
in_dir=opts.directory
outfile=opts.outfile
trimming_path=opts.trimming


# open outfile for writing
fhw = open(outfile, "w+")
# write colnames to outfile
fhw.write('Sample' + '\t' + 'Input_Reads' + '\t' + 'Surviving' + '\t' + 'Dropped' + '\n')


# for file ending in .err in directory
for file in os.listdir(in_dir):
    filename = os.fsdecode(file)
    if filename.endswith(".err"):
        # read in the file as a pandas df
        path_file=in_dir + '/' + filename
        df=pd.read_table(path_file, skiprows=[0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], skipfooter=1, sep='\s+', header=None, engine='python')

        # Rename sample name
        df.iat[0,1]=re.sub(trimming_path + '/', '', df.iat[0,1])
        df.iat[0,1]=re.sub('.fastq.gz', '', df.iat[0,1])

        # define sample name
        sample=df.iat[0,1]

        # define input_reads
        input_reads=df.iat[1,1]

        # define surviving
        surviving=df.iat[1,3] + ' ' + df.iat[1,4]

        # define dropped
        dropped=df.iat[1,6] + ' ' + df.iat[1,7]
        
        # write to outfile
        fhw.write(sample + '\t' + input_reads + '\t' + surviving + '\t' + dropped + '\n')

    else:
        continue
    
fhw.close()

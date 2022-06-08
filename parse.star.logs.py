#!/home/groups/hoolock2/u0/bd/bin/miniconda3/envs/ATAC2/bin/python

#----------------------------------------------------------------------------------------------------------------#
# Purpose: to parse relevant info from a directory of STAR log files                                             #
#          and produce an outfile containing a table of alignment stats per sample                               #
#                                                                                                                #
# Useage: ./parse.star.logs.py -d /path/to/star/reports -o path/to/outfile/outfile                               #
#----------------------------------------------------------------------------------------------------------------#

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
fhw.write('Sample' + '\t' + 'Input_Reads' + '\t' + 'Unq_Mapped_Reads'  + '\t' + 'Unq_Percent' + '\t' + 'MultiMapped_Reads' + '\t' + 'MultiMapped_Percent' + '\t' + 'Too_Many_Loci' + '\t' + 'Too_Many_Loci_Percent' + '\t' + 'Unmapped_TooShort' + '\t' + 'Unmapped_Mismatches' + '\t' + 'Unmapped_Other' + 'Chimeric_Reads' + '\n')

# for file ending in .Log.final.out in directory
for file in os.listdir(in_dir):
    filename = os.fsdecode(file)
    if filename.endswith(".Log.final.out"):
        # read in the file as a pandas df
        path_file=in_dir + '/' + filename
        df=pd.read_table(path_file, skiprows=[0, 1, 2, 3, 4, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 27, 31, 32], sep='\t', header=None, engine='python')

        # set sample variable
        sample=re.sub('.star.Log.final.out', '', filename)

        # define other variables to export
        input_reads=df.iat[0,1]
        unq_mapped=df.iat[1,1]
        unq_percent=df.iat[2,1]
        multi=df.iat[3,1]
        multi_percent=df.iat[4,1]
        too_many=df.iat[5,1]
        too_many_percent=df.iat[6,1]
        unmapped_mismatch=df.iat[7,1]
        unmapped_short=df.iat[8,1]
        unmapped_other=df.iat[9,1]
        chimeric=df.iat[10,1]

        # write to outfile
        fhw.write(sample + '\t' + input_reads + '\t' + unq_mapped + '\t' + unq_percent + '\t' + multi + '\t' + multi_percent + '\t' + too_many + '\t' + too_many_percent + '\t' + unmapped_mismatch + '\t' + unmapped_short + '\t' + unmapped_other + '\t' + chimeric + '\n')

    else:
        continue
fhw.close()

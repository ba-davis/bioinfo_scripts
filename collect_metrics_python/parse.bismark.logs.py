#!/home/groups/hoolock/u1/bd/bin/miniconda3/envs/Bisulfite_seq/bin/python

#----------------------------------------------------------------------------------------------------------------#
# Purpose: to parse relevant info from a directory of bismark log files                                          #
#          and produce an outfile containing a table of stats per sample                                         #
#                                                                                                                #
# Useage: ./parse.bismark.logs.py -d /path/to/reports -o path/to/outfile -t path/to/trimmed/fastqs               #
#----------------------------------------------------------------------------------------------------------------#

# Make sure desired outfile doesn't end with ".txt" otherwise an error will occur (when the loop tries to open this txt file)
# the output will still finish correctly before it gets to that point

#./parse.bismark.logs.py -d /home/groups/hoolock/u1/bd/Projects/ECP1/spring2019.redo/rrbs/bismark/reports -o /home/groups/hoolock/u1/bd/Projects/ECP1/spring2019.redo/rrbs/bismark/reports/summary -t /home/groups/hoolock/u1/bd/Projects/ECP1/spring2019.redo/rrbs/trimming

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
fhw.write('Sample' + '\t' + 'Input_Reads' + '\t' + 'Unique_Alignments' + '\t' + 'Alignment_Rate' + '\t' + 'No_Alignments' + '\t' + 'Multimapped' + '\t' + 'Discarded' + '\t' + 'Total_Cs_Analyzed' + '\t' + 'CpG_Context' + '\t' + 'CHG_Context' + '\t' + 'CHH_Context' + '\t' + 'Unknown_Context' + '\n')


# for file ending in .txt in directory
for file in os.listdir(in_dir):
    filename = os.fsdecode(file)
    if filename.endswith(".txt"):
        # read in the file as a pandas df
        path_file=in_dir + '/' + filename

        df=pd.read_csv(path_file, skiprows=[1,2,3,4,5,12,13,14,15,16,17,18,19,20,21,22,24,25,26,27,28,29,30,31,32,33,34,39,40,41], sep='\s+', header=None, names=list(range(0,15)), engine='python')
         
        # Rename sample name
        df.iat[0,3]=re.sub(trimming_path + '/', '', df.iat[0,3])
        df.iat[0,3]=re.sub('_trimmed.fq.gz', '', df.iat[0,3])
        sample_name=df.iat[0,3]

        # Get Input Reads
        input_reads=df.iat[1,4]
        
        # Get Unq Aln
        unq_aln=str(int(df.iat[2,12]))

        # Get Alignment Rate
        aln_rate=df.iat[3,2]

        # Get No Alignments
        no_aln=df.iat[4,7]

        # Get Multimappers
        multi=df.iat[5,5]

        # Get Discarded
        discarded=df.iat[6,11]

        # Get Total C's
        total_c=df.iat[7,5]

        # Get cpg context
        cpg=df.iat[8,5]

        # Get chg context
        chg=df.iat[9,5]

        # Get chh context
        chh=df.iat[10,5]

        # Get unknown
        unknown=df.iat[11,8]

        # write to outfile
        fhw.write(sample_name + '\t' + input_reads + '\t' + unq_aln + '\t' + aln_rate + '\t' + no_aln + '\t' + multi + '\t' + discarded + '\t' + total_c + '\t' + cpg + '\t' + chg + '\t' + chh + '\t' + unknown + '\n')

    else:
        continue

fhw.close()

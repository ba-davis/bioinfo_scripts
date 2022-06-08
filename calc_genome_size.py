#!/usr/bin/python

import optparse

# Initialize command line options for input file
p=optparse.OptionParser()
p.add_option("-i", action = "store", dest = "infile")
opts,args=p.parse_args()
infile=opts.infile

# open the input file for reading
fh=open(infile, "r")

# initialize counting variables
linecount=0      # keep track of lines for parsing the file line by line 
total_bp_count=0 # tally up total number of bp encountered
N_count=0        # tally up total number of "N" encountered

# parse the infile to count the number of ATCG bp's and number of N bp's
for line in fh:
    line=line.strip('\n')
    linecount += 1
    if list(line)[0] == ">":
        continue
    else:
        total_bp_count += len(line)
        N_count += line.count('N')

effective_gsize=total_bp_count - N_count

print("Total BP Count: %s" % total_bp_count)
print("Number of N's: %s" % N_count)
print("Effective Genome Size: %s" % effective_gsize)

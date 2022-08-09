

# conda activate tidymodels

library(writexl)


#---------------------------------------#
# INPUT VARS

# path to annot output txt files
dir <- "/home/groups/hoolock2/u0/bd/Projects/ECP60/data/homer/homer_on_ar_halfsite_peaks"
# ending of annot txt files to read in
suffix <- "annot.output.txt"
# desired output excel file name
outfile <- "homer_annot.xlsx"
# desired name of column 1 (often "PeakID" or "DMR_ID")
col1_name <- "PeakID"
# by default, will keep column 1 and first col of TF motifs until the end
# this var defines the column number of the first TF motif
tf_motif_col <- 22

#----------------

# define a new variable "myfiles" based on the above two variables
myfiles <- list.files(dir, pattern=paste0(suffix, "$"), full=T)

# define desired names of dfs/comparisons/excel sheets
df_names <- gsub(paste0(dir, "/"), "", myfiles)
df_names <- gsub(".knownMotifs.all.annot.output.txt", "", df_names)
df_names <- gsub("_AR.ar_halfsite", "", df_names)

#---------------------------------------#

# Read in the input files

# read in the files into a list
res <- lapply(myfiles, read.delim, header=T)

# Clean up columns and col1 name (just col 1 and TF motif cols)
for (i in 1:length(res)) {
  res[[i]] <- res[[i]][ ,c(1,tf_motif_col:ncol(res[[i]]))]
  colnames(res[[i]])[1] <- col1_name
}

# define names of res
names(res) <- df_names

# export excel file
write_xlsx(res, outfile)

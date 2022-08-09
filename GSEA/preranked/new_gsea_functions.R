
library(dplyr)
library(ggplot2)

# function to select significant results from multiple GSEA runs into one table

# inputs vars:
#   inpath: path to GSEA output folders (gene sets)
#           assumes this location only contains GSEA output folders
#   my_pval: name of the column from gsea_report_for_na*.xls file to use for cutoff
#            usually one of ("NOM.p.val", "FDR.q.val", "FWER.p.val")
#            defaults to "FDR.q.val"
#   pval_cutoff: cutoff value for the above pval to define significance to include in res table
#                defaults to 0.25
#   outfile: desires name of output txt file
#            defaults to "GSEA_sig_results.txt"

summarize_gsea_res <- function(inpath, my_pval="FDR.q.val", pval_cutoff=0.25, outfile="GSEA_sig_results.txt") {

  # Obtain variables from input vars
  # number of output folders (gsea outputs)
  n_outs <- length(list.dirs(inpath, recursive=FALSE))
  print(paste0("Found ", n_outs, " GSEA output directories."))
  # full dir paths
  dir_paths <- list.dirs(inpath)
  # obtain the paths to each "my_analysis" subdirectory
  # assumes a structure where every 3rd path is to a "my_analysis" folder
  imp_paths <- dir_paths[seq(3, length(dir_paths), 3)]

  # read in the gsea report for na pos and na neg files
  gsea_pos_res <- list()
  gsea_neg_res <- list()
  for (i in 1:length(imp_paths)) {
    gsea_pos_res[[i]] <- read.delim(paste0(imp_paths[i], "/", list.files(imp_paths[i], pattern="^gsea_report_for.*xls")[1]), header=T)
    gsea_neg_res[[i]] <- read.delim(paste0(imp_paths[i], "/", list.files(imp_paths[i], pattern="^gsea_report_for.*xls")[2]), header=T)
  }

  print(paste0("pos category is ", list.files(imp_paths[i], pattern="^gsea_report_for.*xls")[1]))
  print(paste0("neg category is ", list.files(imp_paths[i], pattern="^gsea_report_for.*xls")[2]))
  
  # add names to each df in the list (name will be gene set)
  names(gsea_pos_res) <- gsub(inpath, "", imp_paths)
  names(gsea_pos_res) <- gsub("my_analysis.*$", "", names(gsea_pos_res))
  names(gsea_pos_res) <- gsub("/", "", names(gsea_pos_res))
  names(gsea_neg_res) <- gsub(inpath, "", imp_paths)
  names(gsea_neg_res) <- gsub("my_analysis.*$", "", names(gsea_neg_res))
  names(gsea_neg_res) <- gsub("/", "", names(gsea_neg_res))

  # add a column specifying gene set to each gsea_res
  for (i in 1:length(gsea_pos_res)) {
    gsea_pos_res[[i]]$Gene_Set <- names(gsea_pos_res)[i]
  }
  for (i in 1:length(gsea_neg_res)) {
    gsea_neg_res[[i]]$Gene_Set <- names(gsea_neg_res)[i]
  }

  # subset each df in gsea_pos_res based on specified pval cutoff
  for (i in 1:length(gsea_pos_res)) {
    gsea_pos_res[[i]] <- gsea_pos_res[[i]][gsea_pos_res[[i]][[my_pval]] < pval_cutoff, ]
  }
  # subset each df in gsea_neg_res based on specified pval cutoff
  for (i in 1:length(gsea_neg_res)) {
    gsea_neg_res[[i]] <- gsea_neg_res[[i]][gsea_neg_res[[i]][[my_pval]] < pval_cutoff, ]
  }

  # Combine dfs
  gsea_pos <- bind_rows(gsea_pos_res)
  gsea_neg <- bind_rows(gsea_neg_res)

  gsea_all <- rbind(gsea_pos, gsea_neg)

  # export
  write.table(gsea_all, outfile, sep="\t", col.names=T, row.names=F, quote=F)

  # return the final df
  return(gsea_all)
}

#-------------------------------------------------------------------------------------------------------#

# Function to combine multiple summarized_gsea results table txt files
# (such as across multiple cell types or comparisons)

# input variables:
#   inpath: path to folder containing only summarized gsea result txt files
combine_summarized_gsea <- function(inpath, suffix="_GSEA_results.txt", export_full_dat=TRUE) {
  # read in each summarized output table
  myfiles <- list.files(inpath, pattern=paste0(suffix, "$"), full=T)
  mydat_list <- lapply(myfiles, function(x) read.delim(x, header=T))

  # add a column to each df to list the name of the comparison/cell type
  names(mydat_list) <- gsub(inpath, "", myfiles)
  names(mydat_list) <- gsub(suffix, "", names(mydat_list))
  names(mydat_list) <- gsub("/", "", names(mydat_list))

  for (i in 1:length(mydat_list)) {
    mydat_list[[i]]$res_id <- names(mydat_list)[i]
  }

  # combine dfs
  mydat <- bind_rows(mydat_list)

  if (export_full_dat==TRUE) {
    # export full data (optional)
    write.table(mydat, "mydat_full.txt", sep="\t", col.names=T, row.names=F, quote=F)

    return(mydat)
  }
  if (export_full_dat==FALSE) {
    return(mydat)
  }
}

#----------------------------------------------------------------------------------------------------#

# Function to make a dotplot of GSEA pathways from a combined_summarized table

# input variables
#   df: a combined summarized table as a data.frame in R
#   my_pval: name of the column from gsea_report_for_na*.xls file to use for cutoff
#            usually one of ("NOM.p.val", "FDR.q.val", "FWER.p.val")
#            defaults to "FDR.q.val"
#   pval_cutoff: cutoff value for the above pval to define significance
#                defaults to 0.05
#   n: number of comparisons/cell_types that the pathway must be sig in to include in plot
#      defaults to 1
#   plotfile: desired name of the plot file
#             defaults to "GSEA_dotplot.pdf"
#   width: width of output plot file
#          defaults to 7
#   height: height of output plot file
#           defaults to 7
make_gsea_dotplot <- function(df, my_pval="FDR.q.val", pval_cutoff=0.05, n=1, plotfile="GSEA_dotplot.pdf", width=7, height=7, rotate_x_lab=FALSE) {

  # convert the res_id column to a factor so that it has levels
  df$res_id <- as.factor(df$res_id)
  
  # for each res_id (cell type/comparison),
  #   - get a vector of "NAME" values with FDR.qval < 0.05 in that res_id
  #   - store in a list of lists
  #   - keep only NAME values that appear in n number of res_id lists
  names_to_include_list <- list()
  for (i in 1:length(levels(df$res_id))) {
    names_to_include_list[[i]] <- df[df$res_id==levels(df$res_id)[i] & df[[my_pval]] < pval_cutoff, "NAME"]
  }

  # unlist the list
  gene_sets <- unlist(names_to_include_list)
  f <- table(gene_sets)
  keep <- names(f)[f >= n]
  plotdf <- df[df$NAME %in% keep, ]

  # plot
  myplot <- ggplot(plotdf) +
    geom_point(aes_string(x="res_id", y="NAME", size=my_pval, color="NES")) +
    scale_color_gradient2(low="blue", mid="white", high="red") +
    scale_size(range = c(0.5,4), trans='reverse') +
    theme_minimal()
  if (rotate_x_lab==TRUE) {
    myplot <- myplot + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  }
  ggsave(filename=plotfile, plot=myplot, width=width, height=height)


  # original plot code
  #myplot <- ggplot(plotdf) +
  #  geom_point(aes_string(x="res_id", y="NAME", size=my_pval, color="NES")) +
  #  scale_color_gradient2(low="blue", mid="white", high="red") +
  #  scale_size_continuous(range = c(0.25, 2)) +
  #  theme_minimal() +
  #  scale_size(trans = 'reverse')
  #if (rotate_x_lab==TRUE) {
  #  myplot <- myplot + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  #}
  #ggsave(filename=plotfile, plot=myplot, width=width, height=height)
}

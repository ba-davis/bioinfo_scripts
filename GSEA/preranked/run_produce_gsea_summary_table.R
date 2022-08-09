
# conda activate tidymodels


source("/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/preranked/new_gsea_functions.R")

library(writexl)

# user defined variables:
# dir: path to base directory containing cell type/ comparison GSEA res directories
# dir_pattern: pattern to identify the output directories
# p_cutoff: value to subset results by
# excel_name: name of output excel file of all results

dir <- "/home/groups/hoolock2/u0/bd/Projects/agarwal/runx1_project_LPS_data/gsea/LPS_HD"
dir_pattern <- "^DE"
p_cutoff <- 0.25
excel_name <- "GSEA_results_summary_HD.xlsx"

# define function to list directories with pattern
my.list.dirs <- function(path=".", pattern=NULL, all.dirs=FALSE,
  full.names=FALSE, ignore.case=FALSE) {
  # use full.names=TRUE to pass to file.info
  all <- list.files(path, pattern, all.dirs,
           full.names=TRUE, recursive=FALSE, ignore.case)
  dirs <- all[file.info(all)$isdir]
  # determine whether to return full names or just dir names
  if(isTRUE(full.names))
    return(dirs)
  else
    return(basename(dirs))
}




# 1. summarize the gsea results (from multiple gene sets) for each cell type/comparison

# Create list of directory paths to GSEA results of each cell type/comparison
dirs <- my.list.dirs(path = dir, pattern = dir_pattern, full.names = T)

# Grab output prefixes from above directory list
prefixes <- gsub(paste0(dir, "/"), "", dirs)

# run summarize gsea function on each dir
res_list <- list()
for (i in 1:length(dirs)) {
  res_list[[i]] <- summarize_gsea_res(inpath = dirs[i],
    my_pval = "FDR.q.val",
    pval_cutoff = p_cutoff,
    outfile = paste0(prefixes[i], "_GSEA_results_summary.txt")
  )
}

# clean up summary results and combine and export excel file
for (i in 1:length(res_list)) {
  # select columns to inclue in excel file
  res_list[[i]] <- res_list[[i]][ ,c(1,4,5,6,7,8,9,13)]
}

#names(res_list) <- lapply(prefixes, substr, start=1, stop=31)
names(res_list) <- c("GMP", "HSC", "Mono", "Pro-Mono", "Progenitor")


write_xlsx(res_list,
  path = excel_name,
  col_names = TRUE,
  format_headers = TRUE
)

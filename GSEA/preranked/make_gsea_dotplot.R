
# conda activate tidymodels

source("/home/groups/hoolock2/u0/bd/scripts_2020/GSEA/new_gsea_functions.R")


# user variables:
# inpath: path to dir containing the gsea res txt files per cell type/comparison
# suffix: suffix of these txt files to identify them and to remove leaving clean name

inpath <- "/home/groups/hoolock2/u0/bd/Projects/agarwal/runx1_project_LPS_data/gsea/LPS_HD/summarize_results"
suffix <- "_GSEA_results_summary.txt"

# 2. combine the summarized gsea res tables from multiple cell types/comparisons into one table

mydat <- combine_summarized_gsea(inpath=inpath,
                                 suffix=suffix,
                                 export_full_dat=TRUE
)

# 3. make a dotplot of pathways shared among cell types/comparisons

# manually edit res_id for plot
mydat$res_id <- gsub(".Markers.expressed", "", mydat$res_id)
mydat$res_id <- gsub("DE.", "", mydat$res_id)

# Make dotplot
make_gsea_dotplot(df=mydat,
                  my_pval="FDR.q.val",
                  pval_cutoff=0.05,
                  n=3,
                  plotfile="GSEA_dotplot_qval0.05_n3.pdf",
                  width=12,
                  height=20,
                  rotate_x_lab=TRUE
)



source("/home/groups/hoolock2/u0/bd/github_repos/bioinfo_scripts/GSEA/preranked/new_gsea_functions.R")

# 2. combine the summarized gsea res tables from multiple cell types/comparisons into one table

mydat <- combine_summarized_gsea(inpath="/home/groups/hoolock2/u0/bd/Projects/agarwal/runx1_project_x_genes_removed_redo/gsea/summarize_results",
                                 suffix="_GSEA_results.txt",
                                 export_full_dat=TRUE
)

#------------------------------#

# 3. make a dotplot of pathways shared among cell types/comparisons
# Use only pathways specified by Mona/Anupriya

# mydat[grep("WNT", mydat$NAME), 1]

my_pathways <- c("SINGH_KRAS_DEPENDENCY_SIGNATURE",
  "HALLMARK_WNT_BETA_CATENIN_SIGNALING",
  "HALLMARK_ALLOGRAFT_REJECTION",
  "HALLMARK_ADIPOGENESIS",
  "ZNF433_TARGET_GENES",
  "VEGF_A_UP.V1_DN",
  "TAF9B_TARGET_GENES",
  "RELA_DN.V1_UP",
  "MEK_UP.V1_DN",
  "KRAS.300_UP.V1_DN",
  "HALLMARK_TGF_BETA_SIGNALING",
  "HALLMARK_PI3K_AKT_MTOR_SIGNALING",
  "HALLMARK_MYC_TARGETS_V1",
  "HALLMARK_G2M_CHECKPOINT",
  "HALLMARK_E2F_TARGETS",
  "GO_POLYSOMAL_RIBOSOME",
  "EGFR_UP.V1_DN",
  "E2F_02"
)

df <- mydat

# # convert the res_id column to a factor so that it has levels
df$res_id <- as.factor(df$res_id)

# subset to include pathways of interest
df2 <- df[df$NAME %in% my_pathways, ]

# subset to include cell types of interest
df3 <- df2[df2$res_id %in% c("GMP", "HSC", "Progenitor", "Mono"), ]

my_pval="FDR.q.val"

# reorder res id factor levels to desired order
df3$res_id <- factor(df3$res_id, levels=c("HSC","Progenitor","GMP", "Mono"))

# Plot dotplot
myplot <- ggplot(df3) +
  geom_point(aes_string(x="res_id", y="NAME", size=my_pval, color="NES")) +
  scale_color_gradient2(low="blue", mid="white", high="red") +
  scale_size(range = c(0.5,4), trans='reverse') +
  theme_minimal()
ggsave(filename="GSEA_GMP_HSC_Progenitor_Mono_dotplot.pdf", plot=myplot, width=7, height=7)

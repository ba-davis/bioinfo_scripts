

# Purpose: To calculate ranks based on log fold change and p-values


# Note: Weird cases

# If the logFC value is 0
#   this causes the sign to be 0 (instead of 1 or -1)
#   this would produce an error if we divide the logP val by the sign of fold change to get the metric
#   this can be solved by multiplying the logP by the sign instead of dividing

# If the pval is 0
#   this causes the -log10(pval) to be infinity (Inf) because log of 0 is undefined
#   this can be solved by setting pvals of 0 to a very small number, smallest for R is '5e-324'

# If the pval is NA
#   these genes will be removed as no p-value is provided

# If the gene expression is not from Human, then GSEA provides chip files to match orthologous genes
#   these chip files exist for mouse and rat Ensembl data
#   change parameter "organism" to "mouse" or "rat" if appropriate

# variables
#myfile <- "DE.GMP_FPD.GMP_Healthy.Markers.txt"
#logFC_col <- "avg_logFC"
#pval_col <- "p_val"
#gene_col <- "X"
#outfilename <- gsub(".txt", ".rnk", myfile)
#organism <- "human"
#chip <- NULL

# option match_gene: default FALSE, set to TRUE if the non-human results contain only gene names and not Ensembl GeneID
#                    this will just convert gene names to uppercase and match them to the chip file
make_rnk_file <- function(myfile, logFC_col, pval_col, gene_col, outfilename=gsub(".txt", ".rnk", myfile), organism="human", chip=NULL, match_gene=FALSE) {
  # read in dat
  mydat <- read.delim(myfile, header=T)

  # set any p_vals which are '0' to '5e-324'
  mydat[pval_col][mydat[pval_col] == 0] <- 5e-324

  # check for any NA p-values and remove genes with these
  num_NA <- nrow(mydat[mydat[pval_col]=="NA", ])
  if (num_NA > 0) {
    print(paste0("Found ", num_NA, " entries with p-values of NA. These genes will be removed."))
    mydat <- mydat[!is.na(mydat[[pval_col]]), ]
  }

  # create a column of the FC sign
  mydat$fcsign <- sign(mydat[[logFC_col]])

  # create new column of log10 Pvalue
  mydat$logP <- -log10(mydat[[pval_col]])

  # create new column of the metric (-log10(Pvalue) and give it the same sign as the LFC value)
  mydat$metric <- mydat$logP * mydat$fcsign

  # order by decreasing metric value
  mydat2 <- mydat[order(mydat$metric, decreasing=T), ]

  # subset to only gene_col and metric col
  mydat3 <- data.frame(gene=mydat2[[gene_col]],
                       metric=mydat2$metric
  )

  # export
  write.table(mydat3, outfilename, sep="\t", col.names=F, row.names=F, quote=F)

  if (organism=="mouse") {
    if (match_gene==FALSE) {
      print("Organism has been specified as mouse.")
      print("Using GSEA ENSEMBL_mouse_gene.chip file to find orthologous genes.")

      # read in the provided chip file
      my_chip <- read.delim(chip, header=T)
      colnames(my_chip)[1] <- "GeneID"

      # subset to only gene_col, metric_col and GeneID col
      mydat3 <- data.frame(GeneID=mydat2$GeneID,
                           gene=mydat2[[gene_col]],
	  	           metric=mydat2$metric
      )
   
      # merge rnk file with chip file on GeneID
      rnk_chip <- merge(mydat3, my_chip, by="GeneID")
      # sort by decreasing metric value
      rnk_chip <- rnk_chip[order(rnk_chip$metric, decreasing=T), ]
      # subset to only gene_col and metric col
      rnk_chip <- rnk_chip[ ,c(4,3)]
    
      print(paste0("Number of genes in original data rnk file: ", nrow(mydat2)))
      print(paste0("Number of genes in chip data rnk file: ", nrow(rnk_chip)))
      print(paste0(nrow(mydat2) - nrow(rnk_chip), " genes were lost after ortholog matching."))

      # export
      new_outfile <- gsub(".rnk", "", outfilename)
      new_outfile <- paste0(new_outfile, ".mouse_chip.rnk")
      write.table(rnk_chip, new_outfile, sep="\t", col.names=F, row.names=F, quote=F)
    }
    if (match_gene==TRUE) {
      print("Organism has been specified as mouse.")
      print("Using GSEA ENSEMBL_mouse_gene.chip file to find orthologous genes.")
      print("Using gene names instead of Ensembl Gene IDs.")

      # read in the provided chip file
      my_chip <- read.delim(chip, header=T)
      colnames(my_chip)[2] <- "gene"

      # set gene column of mydat3 to uppercase
      mydat3$gene <- toupper(mydat3$gene)
      #print(head(mydat3))

      # merge rnk file with chip file on gene_col
      rnk_chip <- merge(mydat3, my_chip, by="gene")
      # sort by decreasing metric value
      rnk_chip <- rnk_chip[order(rnk_chip$metric, decreasing=T), ]
      #print(head(rnk_chip))
      # subset to only gene_col and metric col
      rnk_chip <- rnk_chip[ ,c(1,2)]
      # check for duplicate gene names
      #nrow(rnk_chip[duplicated(rnk_chip$gene), ])
      print(paste0("Found ", nrow(rnk_chip[duplicated(rnk_chip$gene), ]), " duplicated genes in final rnk file."))
      print("Removing duplicates.")
      rnk_chip <- rnk_chip[!duplicated(rnk_chip$gene), ]

      print(paste0("Number of genes in original data rnk file: ", nrow(mydat2)))
      print(paste0("Number of genes in chip data rnk file: ", nrow(rnk_chip)))
      print(paste0(nrow(mydat2) - nrow(rnk_chip), " genes were lost after ortholog matching."))

      # export
      new_outfile <- gsub(".rnk", "", outfilename)
      new_outfile <- paste0(new_outfile, ".mouse_chip.rnk")
      write.table(rnk_chip, new_outfile, sep="\t", col.names=F, row.names=F, quote=F)
    }
  }
}

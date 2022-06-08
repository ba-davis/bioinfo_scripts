/usr/bin/Rscript

# My sumStats function for DESeq2 results object
sumStats <- function(x,fc=1,pc=0.05,pa=FALSE){
  # Use the adjusted p-value for the final two columns and the upfc,dnfc cutoff
  up <- x$log2FoldChange > 0
  dn <- x$log2FoldChange < 0

  padj <- x$padj < pc
  pval <- x$pvalue < pc
  if(pa){
    ng.up <- x$log2FoldChange > fc & padj
    ng.dn <- x$log2FoldChange < -1*fc & padj
  }else{
    ng.up <- x$log2FoldChange[x$log2FoldChange > fc & pval]
    ng.dn <- x$log2FoldChange[x$log2FoldChange < -1*fc & pval]
  }
  rmin <- min(x$log2FoldChange[pval & up], na.rm=TRUE)
  rmax <- max(x$log2FoldChange[pval & dn], na.rm=TRUE)

  cat(c("padj", "pval","min.up","min.dn", "up","dn"),"\n")
  cat(c(sum(padj,na.rm=TRUE), sum(pval,na.rm=TRUE), sprintf("%.3f",rmin), sprintf("%.3f",rmax), sum(ng.up, na.rm=TRUE), sum(ng.dn, na.rm=TRUE)), "\n")
  return(list(up=which(pval & up), dn=which(pval & dn), upfc=which(ng.up), dnfc=which(ng.dn), padj=which(padj)))
}

# run sumStats
#my.stats <- sumStats(res, fc=1, pc=0.1, pa=TRUE)


infile <- "KO_vs_WT_veh_p0.05.hypo.annot.output.txt"

outfile <- gsub("annot.output.txt", "annot.output.clean.txt", infile)
foo <- read.delim(infile, header=T)
foo2 <- foo[ ,c(1,22:ncol(foo))]
colnames(foo2)[1] <- "Peak_ID"
write.table(foo2, outfile, sep="\t", col.names=T, row.names=F, quote=F)

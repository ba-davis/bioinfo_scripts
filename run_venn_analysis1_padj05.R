
# Use custom functions and R VennDiagram to make venn diagrams

# conda activate RNAseq_v2020
library(VennDiagram)


source("/home/groups/hoolock2/u0/bd/Projects/ECP73/data/plots/venn_diagrams/venndiagram_functions.R")


# define comparison names in the order you read the files in
comp_names <- c("BPA_only", "Low_E2_only")

inpath <- "/home/groups/hoolock2/u0/bd/Projects/ECP73/data/homer/input/"

#----------------------------------#
# padj05

infile1 <- paste0(inpath, "padj05/GR4_v_GR1.padj05.txt")
infile2 <- paste0(inpath, "padj05/GR2_v_GR1.padj05.txt")

# read in the results files
res1 <- read.delim(infile1, header=T)
res2 <- read.delim(infile2, header=T)

sig_genes <- prepvenn2(res1, res2, "up")
names(sig_genes) <- comp_names
plotvenn2(sig_genes, fileprefix="analysis1_padj05_up.Venn_Diagram.pdf", scaled_bool=TRUE)

sig_genes <- prepvenn2(res1, res2, "down")
names(sig_genes) <- comp_names
plotvenn2(sig_genes, fileprefix="analysis1_padj05_down.Venn_Diagram.pdf", scaled_bool=TRUE)

#-------------------------------------#
# padj05_esr1GainedPeaks

infile1 <- paste0(inpath, "padj05_esr1GainedPeaks/GR4_v_GR1.padj05.esr1GainedPeaks.50kb.txt")
infile2 <- paste0(inpath, "padj05_esr1GainedPeaks/GR2_v_GR1.padj05.esr1GainedPeaks.50kb.txt")

# read in the results files
res1 <- read.delim(infile1, header=T)
res2 <- read.delim(infile2, header=T)

sig_genes <- prepvenn2(res1, res2, "up")
names(sig_genes) <- comp_names
plotvenn2(sig_genes, fileprefix="analysis1_padj05_esr1GainedPeaks_up.Venn_Diagram.pdf", scaled_bool=TRUE)

sig_genes <- prepvenn2(res1, res2, "down")
names(sig_genes) <- comp_names
plotvenn2(sig_genes, fileprefix="analysis1_padj05_esr1GainedPeaks_down.Venn_Diagram.pdf", scaled_bool=TRUE)

#------------------------------------#
# padj05_esr1GainedPeaks_FoxMotif

infile1 <- paste0(inpath, "padj05_esr1GainedPeaks_FoxMotif/GR4_v_GR1.padj05.esr1GainedPeaks.50kb.foxMotif.txt")
infile2 <- paste0(inpath, "padj05_esr1GainedPeaks_FoxMotif/GR2_v_GR1.padj05.esr1GainedPeaks.50kb.foxMotif.txt")

# read in the results files
res1 <- read.delim(infile1, header=T)
res2 <- read.delim(infile2, header=T)

sig_genes <- prepvenn2(res1, res2, "up")
names(sig_genes) <- comp_names
plotvenn2(sig_genes, fileprefix="analysis1_padj05_esr1GainedPeaks_FoxMotif_up.Venn_Diagram.pdf", scaled_bool=TRUE)

sig_genes <- prepvenn2(res1, res2, "down")
names(sig_genes) <- comp_names
plotvenn2(sig_genes, fileprefix="analysis1_padj05_esr1GainedPeaks_FoxMotif_down.Venn_Diagram.pdf", scaled_bool=TRUE)

#-----------------------------------#
# padj05_esr1Peaks

infile1 <- paste0(inpath, "padj05_esr1Peaks/GR4_v_GR1.padj05.esr1Peaks.50kb.txt")
infile2 <- paste0(inpath, "padj05_esr1Peaks/GR2_v_GR1.padj05.esr1Peaks.50kb.txt")

# read in the results files
res1 <- read.delim(infile1, header=T)
res2 <- read.delim(infile2, header=T)

sig_genes <- prepvenn2(res1, res2, "up")
names(sig_genes) <- comp_names
plotvenn2(sig_genes, fileprefix="analysis1_padj05_esr1Peaks_up.Venn_Diagram.pdf", scaled_bool=TRUE)

sig_genes <- prepvenn2(res1, res2, "down")
names(sig_genes) <- comp_names
plotvenn2(sig_genes, fileprefix="analysis1_padj05_esr1Peaks_down.Venn_Diagram.pdf", scaled_bool=TRUE)

#--------------------------------------#
# padj05_esr1Peaks_FoxMotif

infile1 <- paste0(inpath, "padj05_esr1Peaks_FoxMotif/GR4_v_GR1.padj05.esr1Peaks.50kb.foxMotif.txt")
infile2 <- paste0(inpath, "padj05_esr1Peaks_FoxMotif/GR2_v_GR1.padj05.esr1Peaks.50kb.foxMotif.txt")

# read in the results files
res1 <- read.delim(infile1, header=T)
res2 <- read.delim(infile2, header=T)

sig_genes <- prepvenn2(res1, res2, "up")
names(sig_genes) <- comp_names
plotvenn2(sig_genes, fileprefix="analysis1_padj05_esr1Peaks_FoxMotif_up.Venn_Diagram.pdf", scaled_bool=TRUE)

sig_genes <- prepvenn2(res1, res2, "down")
names(sig_genes) <- comp_names
plotvenn2(sig_genes, fileprefix="analysis1_padj05_esr1Peaks_FoxMotif_down.Venn_Diagram.pdf", scaled_bool=TRUE)


# conda activate RNAseq_v2020

# PURPOSE: make venn diagrams of overlapping genes from the comparisons
# Analysis 1 venn diagrams will have 3 circles (3 comparisons)
# Analysis 2 venn diagrams will have 2 circles (2 comparisons)

# Analysis 1 Comparisons:
#   - GR4 v GR1 (BPA_only vs DMSO)
#   - GR2 v GR1 (Low_E2_only vs DMSO)
#   - GR3 v GR1 (High_E2_only vs DMSO)

# Analysis 2 Comparisons:
#   - GR5 v GR2 (Low_E2_BPA vs Low_E2_only)
#   - GR6 v GR3 (High_E2_BPA vs High_E2_only)

# 1. Upregulated Genes Analysis 1 (3 groups compared to DMSO: BPA_only, LowE2_only, HighE2_only)
# 2. Downregulated Genes from Analysis 1 (same comps)
# 3. Upregulated Genes within 50kb of ESR1 peak
# 4. Downregulated Genes within 50kb of ESR1 peak
# 5. Upregulated Genes within 50kb of ESR1 peak and with FOX motif
# 6. Downregulated Genes within 50kb of ESR1 peak and with FOX motif
# 7. Upregulated Genes within 50kb of ESR1 gained peak
# 8. Downregulated Genes within 50kb of ESR1 gained peak
# 9. Upregulated Genes within 50kb of ESR1 gained peak and with FOX motif
# 10. Downregulated Genes within 50kb of ESR1 gained peak and with FOX motif

# For each upregulated or downregulated gene set, there are 5 possible filtered groups:
# - sig_gene 
#       - sig_gene_esr1Peak
#             - sig_gene_esr1Peak_FOXmotif
#       - sig_gene_esr1GainedPeak 
#             - sig_gene_esr1GainedPeak_FOXmotif 

#--------------------------------------------------------------#


library(VennDiagram)
#library(gplots)

#------------------#
# Analysis 1 Venns #
#------------------#

# define comparison names in the order you read the files in
comp_names <- c("BPA_only", "Low_E2_only", "High_E2_only")

inpath <- "/home/groups/hoolock2/u0/bd/Projects/ECP73/data/homer/input/"

#--------#
# padj05 #
#--------#
# read in the results files
res1 <- read.delim(paste0(inpath, "padj05/GR4_v_GR1.padj05.txt"), header=T)
res2 <- read.delim(paste0(inpath, "padj05/GR2_v_GR1.padj05.txt"), header=T)
res3 <- read.delim(paste0(inpath, "padj05/GR3_v_GR1.padj05.txt"), header=T)


# get upregulated genes
res1.up <- res1[res1$logFC > 0, ]
res2.up <- res2[res2$logFC > 0, ]
res3.up <- res3[res3$logFC > 0, ]

# get downregulated genes
res1.dn <- res1[res1$logFC < 0, ]
res2.dn <- res2[res2$logFC < 0, ]
res3.dn <- res3[res3$logFC < 0, ]

# upregulated plot
sig_genes <- list(res1.up$GeneID, res2.up$GeneID, res3.up$GeneID)
names(sig_genes) <- comp_names
#VENN.LIST <- sig_genes
#venn.plot <- venn.diagram(VENN.LIST , NULL, fill=c("red", "darkblue", "yellow"), alpha=c(0.5,0.5,0.5), cex = 2, cat.fontface=4, category.names=comp_names, main="Upregulated padj < 0.05")
#pdf("analysis1_padj05_up.Venn_Diagram.pdf")
#grid.draw(venn.plot)
#dev.off()



plotvenn2(sig_genes, fileprefix="analysis1_padj05_up.Venn_Diagram.pdf")


#-------------#

prepvenn3 <- function(res1, res2, res3, direction, gene_col) {
    if (direction=="up") {
        # get upregulated genes
        res1.up <- res1[res1$logFC > 0, ]
        res2.up <- res2[res2$logFC > 0, ]
        res3.up <- res3[res3$logFC > 0, ]

	# Check for groups of 0 length
        #for (x in c(res1.up, res2.up, res3.up)) {
	#    if(nrow(x) < 1 == T) {
	#        print(paste0("Note ", x, " has 0 elements."))
	#    }
	#}
	sig_genes <- list(res1.up$GeneID, res2.up$GeneID, res3.up$GeneID)
	return(sig_genes)
    }

    else if (direction=="down") {
        # get downregulated genes
        res1.dn <- res1[res1$logFC < 0, ]
        res2.dn <- res2[res2$logFC < 0, ]
        res3.dn <- res3[res3$logFC < 0, ]

        
        # Check for groups of 0 length
        #for (x in c(res1.dn, res2.dn, res3.dn)) {
        #    if(nrow(x) < 1) {
        #        print(paste0("Note ", x, " has 0 elements."))
        #    }
        #}
        sig_genes <- list(res1.dn$GeneID, res2.dn$GeneID, res3.dn$GeneID)
        return(sig_genes)
    }
}



# Draw Double Venn
plotvenn2 <- function(input_list,
    cat_names=names(input_list),
    scaled_bool=T,
    color1="red",
    color2="darkblue",
    cat_pos=c(0,0),
    fileprefix="Venn_Diagram.pdf") {

    # calculate overlaps
    overlap <- calculate.overlap(input_list)
    
    # construct venn diagram
    venn.plot <- draw.pairwise.venn(area1=length(overlap[["a1"]]),
        area2=length(overlap[["a2"]]),
        cross.area=length(overlap[["a3"]]),
        category=cat_names,
        fill=c(color1, color2),
        euler.d=scaled_bool,
        scaled=scaled_bool,
        cex=2,
        cat.fontface=4,
        ext.percent=c(0,0,0),
        cat.pos=cat_pos)

    # export plotfile
    pdf(paste0(fileprefix))
    grid.draw(venn.plot)
    dev.off()
}



# Draw Triple Venn
plotvenn3 <- function(input_list,
    cat_names=names(input_list),
    scaled_bool=TRUE,
    color1="red",
    color2="darkblue",
    color3="yellow",
    title=NULL,
    cat_pos=c(0,0,180),
    ext_percent=c(0.5,0.5,0.5),
    fileprefix="Venn_Diagram.pdf") {

    # calculate overlaps
    overlap <- calculate.overlap(input_list)
    names(overlap) <- c("a123", "a12", "a13", "a23", "a1", "a2", "a3")
    
    # construct venn diagram
    #overrideTriple=scaled_bool
    venn.plot <- draw.triple.venn(area1=sum(length(overlap[["a12"]]),
            length(overlap[["a13"]]), length(overlap[["a123"]]),
	    length(overlap[["a1"]])),
        area2=sum(length(overlap[["a12"]]), length(overlap[["a23"]]),
	    length(overlap[["a123"]]), length(overlap[["a2"]])),
        area3=sum(length(overlap[["a23"]]), length(overlap[["a13"]]),
	    length(overlap[["a123"]]), length(overlap[["a3"]])),
        n12=length(overlap[["a12"]]) + length(overlap[["a123"]]),
        n23=length(overlap[["a23"]]) + length(overlap[["a123"]]),
        n13=length(overlap[["a13"]]) + length(overlap[["a123"]]),
        n123=length(overlap[["a123"]]),
        category=cat_names,
        euler.d=FALSE,
        scaled=FALSE,
        fill=c(color1,color2,color3),
        cex=2,
        cat.fontface=4,
	cat.pos=cat_pos,
	ext.percent=ext_percent,
        main=title)

    # export plotfile
    pdf(paste0(fileprefix))
    grid.draw(venn.plot)
    dev.off()
}

#-------------#





scaled_bool <- TRUE
fileprefix <- "analysis1_padj05_up.Venn_Diagram.pdf"

overlap <- calculate.overlap(sig_genes)
venn.plot <- draw.pairwise.venn(area1=length(overlap[["a1"]]),
  area2=length(overlap[["a2"]]),
  cross.area=length(overlap[["a3"]]),
  category=comp_names[c(1,2)],
  fill=c("red", "darkblue"),
  euler.d=scaled_bool,
  scaled=scaled_bool,
  cex=2,
  cat.fontface=4,
  ext.percent=c(0,0,0),
  cat.pos=c(0,0))
pdf(paste0(fileprefix))
grid.draw(venn.plot)
dev.off()

# Draw Triple Venn
overlap <- calculate.overlap(sig_genes)
names(overlap) <- c("a123", "a12", "a13", "a23", "a1", "a2", "a3")
#overrideTriple=T
venn.plot <- draw.triple.venn(area1=nrow(res1.up),
  area2=nrow(res2.up),
  area3=nrow(res3.up),
  n12=length(overlap[["a12"]]),
  n23=length(overlap[["a23"]]),
  n13=length(overlap[["a13"]]),
  n123=length(overlap[["a123"]]),
  category=comp_names,
  euler.d=FALSE,
  scaled=FALSE)
  #fill=c("red", "darkblue", "yellow"),
  #cex=2,
  #cat.fontface=4,
  #main="Upregulated padj < 0.05")
pdf("test.pdf")
#pdf("analysis1_padj05_up.Venn_Diagram.pdf")
grid.draw(venn.plot)
dev.off()








venn.plot <- draw.triple.venn(area1=100,
  area2=50,
  area3=20,
  n12=15,
  n23=5,
  n13=3,
  n123=2,
  category=comp_names,
  euler.d=T,
  scaled=T,
  fill=c("red", "darkblue", "yellow"))
pdf("test.pdf")
grid.draw(venn.plot)
dev.off()







# TvsC
TvsC.sigs <- list(TvsC$CpG_ID, limma.TvsC$CpG_ID)
names(TvsC.sigs) <- c("methylKit","limma")
VENN.LIST <- TvsC.sigs
venn.plot <- venn.diagram(VENN.LIST , NULL, fill=c("darkmagenta", "darkblue"), alpha=c(0.5,0.5), cex = 2, cat.fontface=4, category.names=c("methylKit", "Limma"), main="Sig DMCs methylKit vs Limma: TvsC")
tiff("TvsC.Limma.MethylKit.Venn_Diagram.tiff")
grid.draw(venn.plot)
dev.off()

### 3-way Venn Diagrams
TWSDvsC.sigs <- list(TWSDvsC$CpG_ID, limma.TWSDvsC$CpG_ID, TWSDvsC.OG$CpG_ID)
names(TWSDvsC.sigs) <- c("methylKit","limma","methylKit.OG")
VENN.LIST <- TWSDvsC.sigs
venn.plot <- venn.diagram(VENN.LIST , NULL, fill=c("darkmagenta", "darkblue", "darksalmon"), alpha=c(0.5,0.5,0.5), cex = 2, cat.fontface=4, category.names=c("methylKit", "Limma","methylKit.OG"), main="Sig DMCs methylKit vs Limma vs methylKit.OG: TWSDvsC")
tiff("TWSDvsC.Limma.MethylKit.3Venn_Diagram.tiff")
grid.draw(venn.plot)
dev.off()

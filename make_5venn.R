
# conda activate rvenns

# VennDiagram
# 5 set venn (quintuple.venn)

# Example code to produce a 5 circle VennDiagram
# todo: export exceel file of group membership
#       clean code for 2Venn and 3Venn and 4Venn
#-----------------------------------#

# Libraries
library(tidyverse)
library(VennDiagram)
library(UpSetR)
library(readxl)
#library(writexl)

# read in excel file of shared cpgs across 5 models
mydat <- read_xlsx("../all_model_cpgs.xlsx")

# Get vectors of CpGs with nonzero coef in each model
mod1 <- mydat %>%
  drop_na(model1_coef) %>%
  filter(model1_coef != 0) %>%
  select(term) %>%
  unlist(., use.names = FALSE)

mod2 <- mydat %>%
  drop_na(model2_coef) %>%
  filter(model2_coef != 0) %>%
  select(term) %>%
  unlist(., use.names = FALSE)

mod3 <- mydat %>%
  drop_na(model3_coef) %>%
  filter(model3_coef != 0) %>%
  select(term) %>%
  unlist(., use.names = FALSE)

mod4 <- mydat %>%
  drop_na(model4_coef) %>%
  filter(model4_coef != 0) %>%
  select(term) %>%
  unlist(., use.names = FALSE)

mod5 <- mydat %>%
  drop_na(model5_coef) %>%
  filter(model5_coef != 0) %>%
  select(term) %>%
  unlist(., use.names = FALSE)

# define input list of vectors
input_list <- list(mod1, mod2, mod3, mod4, mod5)

# define category names and plot title
cat_names <- c("M1", "M2", "M3", "M4", "M5")
title <- "Shared CpGs among 5 models"

# calculate overlaps
overlap <- calculate.overlap(input_list)

# produce the size vector to use for plotting function
size_vec <- calculate_5venn_sizes(overlap)

# create venn_plot object
venn_plot <- create5venn(size_vec)

# export plotfile
pdf("test_venn.pdf")
grid.draw(venn_plot)
dev.off()



# function to clean overlaps output
calculate_5venn_sizes <- function(overlap) {
  # define better names for overlaps
  names(overlap) <- c("a12345", "a1234", "a1235", "a1245", "a1345", "a2345",
  "a245", "a234", "a134", "a123", "a235", "a125", "a124", "a145", "a135",
  "a345", "a45", "a24", "a34", "a13", "a23", "a25", "a12", "a14", "a15",
  "a35", "a5", "a4", "a3", "a2", "a1")

  # calculate input sizes for plotting function
  area1_val <- sum_areas(overlap, "1")
  area2_val <- sum_areas(overlap, "2")
  area3_val <- sum_areas(overlap, "3")
  area4_val <- sum_areas(overlap, "4")
  area5_val <- sum_areas(overlap, "5")
  n12_val <- sum_areas(overlap, "1.*2")
  n13_val <- sum_areas(overlap, "1.*3")
  n14_val <- sum_areas(overlap, "1.*4")
  n15_val <- sum_areas(overlap, "1.*5")
  n23_val <- sum_areas(overlap, "2.*3")
  n24_val <- sum_areas(overlap, "2.*4")
  n25_val <- sum_areas(overlap, "2.*5")
  n34_val <- sum_areas(overlap, "3.*4")
  n35_val <- sum_areas(overlap, "3.*5")
  n45_val <- sum_areas(overlap, "4.*5")
  n123_val <- sum_areas(overlap, "1.*2.*3")
  n124_val <- sum_areas(overlap, "1.*2.*4")
  n125_val <- sum_areas(overlap, "1.*2.*5")
  n134_val <- sum_areas(overlap, "1.*3.*4")
  n135_val <- sum_areas(overlap, "1.*3.*5")
  n145_val <- sum_areas(overlap, "1.*4.*5")
  n234_val <- sum_areas(overlap, "2.*3.*4")
  n235_val <- sum_areas(overlap, "2.*3.*5")
  n245_val <- sum_areas(overlap, "2.*4.*5")
  n345_val <- sum_areas(overlap, "3.*4.*5")
  n1234_val <- sum_areas(overlap, "1.*2.*3.*4")
  n1235_val <- sum_areas(overlap, "1.*2.*3.*5")
  n1245_val <- sum_areas(overlap, "1.*2.*4.*5")
  n1345_val <- sum_areas(overlap, "1.*3.*4.*5")
  n2345_val <- sum_areas(overlap, "2.*3.*4.*5")
  n12345_val <- sum_areas(overlap, "1.*2.*3.*4.*5")

  # Store area sizes in a numeric vector
  size_vec <- c(area1_val, area2_val, area3_val, area4_val, area5_val,
  n12_val, n13_val, n14_val, n15_val, n23_val, n24_val, n25_val,
  n34_val, n35_val, n45_val, n123_val, n124_val, n125_val, n134_val,
  n135_val, n145_val, n234_val, n235_val, n245_val, n345_val, n1234_val,
  n1235_val, n1245_val, n1345_val, n2345_val, n12345_val)

  return(size_vec)
}

# Function to return the sum for selected entries in the overlaps vector
# Inputs are the overlap results vector, and a character of numbers to include
#   in the names of the overlap entries
sum_areas <- function(overlap, grepfor) {
  names_of_interest <- grep(grepfor, names(overlap), value = TRUE)
  total <- 0
  for (i in 1:length(names_of_interest)) {
    newval <- length(overlap[[names_of_interest[i]]])
    total <- total + newval
  }
  return(total)
}


# make venn diagram
create5venn <- function(size_vec,
  fill_col = c("red", "yellow", "orange", "blue", "green"),
  font_size = 1, lty_val = "blank") {
    venn_plot <- draw.quintuple.venn(area1 = size_vec[1],
    area2 = size_vec[2],
    area3 = size_vec[3],
    area4 = size_vec[4],
    area5 = size_vec[5],
    n12 = size_vec[6],
    n13 = size_vec[7],
    n14 = size_vec[8],
    n15 = size_vec[9],
    n23 = size_vec[10],
    n24 = size_vec[11],
    n25 = size_vec[12],
    n34 = size_vec[13],
    n35 = size_vec[14],
    n45 = size_vec[15],
    n123 = size_vec[16],
    n124 = size_vec[17],
    n125 = size_vec[18],
    n134 = size_vec[19],
    n135 = size_vec[20],
    n145 = size_vec[21],
    n234 = size_vec[22],
    n235 = size_vec[23],
    n245 = size_vec[24],
    n345 = size_vec[25],
    n1234 = size_vec[26],
    n1235 = size_vec[27],
    n1245 = size_vec[28],
    n1345 = size_vec[29],
    n2345 = size_vec[30],
    n12345 = size_vec[31],
    category = cat_names,
    euler.d = FALSE,
    scaled= FALSE,
    fill = fill_col,
    cex = font_size,
    cat.fontface=2,
    #cat.pos=cat_pos,
    #ext.percent=ext_percent,
    lty = lty_val,
    main = title)

    return(venn_plot)
}

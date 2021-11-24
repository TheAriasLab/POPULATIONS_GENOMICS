library(SNPRelate)
library(pheatmap)
library(dplyr)
library(wesanderson)
library(viridisLite)

colors <- inferno(4)
annoCol <- list(group=c(c1=colors[1], c2=colors[2], c3=colors[3], c4=colors[4]))
# colors 
color=wes_palette("Zissou1", 250, type = "continuous")
# load vcffile 
SNPRelate::snpgdsVCF2GDS("/home/j/BIOINFORMATICA/POPULATIONS_GENOMICS/popstatistics/PCA2/coco_lite.vcf"
                         , out.fn = "~test.gds"
                         , method = "copy.num.of.ref")

# load ids for genetic pools
# GROUP 1
c1 <- read.table("./../groups/c1_ids.txt")
colnames(c1) <- "id"
row.names(c1) <- c1$id
c1 <- c1 %>% mutate(group = "c1") %>% select(group)
# GROUP 2
c2 <- read.table("./../groups/c2_ids.txt")
colnames(c2) <- "id"
row.names(c2) <- c2$id
c2 <- c2 %>% mutate(group = "c2") %>% select(group)
# GROUP 3
c3 <- read.table("./../groups/c3_ids.txt")
colnames(c3) <- "id"
row.names(c3) <- c3$id
c3 <- c3 %>% mutate(group = "c3") %>% select(group)
# GROUP 4
c4 <- read.table("./../groups/c4_ids.txt")
colnames(c4) <- "id"
row.names(c4) <- c4$id
c4 <- c4 %>% mutate(group = "c4") %>% select(group)
# BIND DATAFRAMES
anot <- rbind(c1, c2, c3, c4)

# LOAD VCF IN GDS FORMAT
file <- SNPRelate::snpgdsOpen("~test.gds")

# CALCULATE KINDSHIP MATRIX
IBD <- SNPRelate::snpgdsIBDMoM(file, autosome.only = F, kinship = T, remove.monosnp = T,sample.id = as.factor(row.names(anot)))
df <- as.data.frame(IBD$kinship)
colnames(df) <- rownames(anot)
row.names(df) <- rownames(anot)
# HEATMAP
pheatmap(df,annotation_row = anot, annotation_col =  anot, color = color, annotation_colors = annoCol, cellwidth = 7.5, cellheight =  7.5)
hist(IBD$kinship, breaks = 30)

png("./heatmap.png",  width = 10, height = 10, res = 300, units = "cm")
dev.off()

# jomare1188@gmail.com

# 1) load libraries
library(tidyverse)
library(viridisLite)
library(ggsci)
library(RColorBrewer)
library(wesanderson)
library(vcfR)
library(adegenet)
library(ggrepel)

# 2) variables and set wd
wd = "/home/j/BIOINFORMATICA/POPULATIONS_GENOMICS/popstatistics/PCA_pacific/code"
setwd(wd)
color=wes_palette("Zissou1", 100, type = "continuous")

# 3) read files with structure ids
read_files <- function(){
c1 <- read.table("./../data/c1_ids.txt")
c1$class <- "c1"

c2 <- read.table("./../data/c2_ids.txt")
c2$class <- "c2"

c3 <- read.table("./../data/c3_ids.txt")
c3$class <- "c3"

c4 <-  read.table("./../data/c4_ids.txt")
c4$class <- "c4"

m <- read.table("./../data/mixed_ids.txt")
m$class <- "m"

h <- read.table("./../data/heigh.csv", sep = ",", header = T)


d <- rbind(c1,c2,c3,c4,m)
colnames(d) <- c("ind", "class")
d_class <- merge(d, h, by = "ind")
d_class$height <- d_class$height/100
return(output = d_class)
}
d_class <- read_files()

# 4) read vcf file
read_vcf_file <- function(x){
vcf <- read.vcfR(x)
gl.coco <- vcfR2genlight(vcf)
ploidy(gl.coco) <- 2
return(output = gl.coco)
}
gl.coco.pacific <- read_vcf_file("./../data/pacific.recode.vcf")
gl.coco.atlantic <- read_vcf_file("./../data/atlantic.recode.vcf")

## 5) make pca to fet coco.pca.scores
make_pca_and_plot <- function(gl, plot_title){

coco.pca <- glPca(gl, nf = 2, parallel = 1)
contrib<-100*coco.pca$eig/sum(coco.pca$eig)
coco.pca.scores <- as.data.frame(coco.pca$scores)
coco.pca.scores$pop <- pop(gl)
coco.pca.scores$ind <- rownames(coco.pca.scores)
d <- coco.pca.scores

# 6) merge PCA with structure class and height
df_full <- merge(d, d_class, by = "ind")

# 7) make plot
p <- ggplot(df_full, aes(x = PC1, y = PC2, color = height, shape = class)) 
p <- p + geom_point(size=3.5, alpha = 1)
p <- p + labs(title = "", col= "Height (m)", shape = "Group")
p <- p + xlab((paste0("PC1 : ",round(100 * (coco.pca$eig[1]/sum(coco.pca$eig)),2),"%")))
p <- p + ylab((paste0("PC2 : ",round(100 * (coco.pca$eig[2]/sum(coco.pca$eig)),2),"%")))
p <- p + scale_colour_gradientn(colours = color)
p <- p + geom_hline(yintercept = 0) 
p <- p + geom_vline(xintercept = 0) 
p <- p + theme_bw()
p <- p + theme( text = element_text(family = "Times New Roman", size=22), 
                panel.border = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.line = element_line(colour = "black"))
p
ggsave(p, filename = paste("./../results/", plot_title, ".png"), units = "cm", width = 15*1.3, height = 15, dpi = 320)
}
make_pca_and_plot(gl.coco.atlantic, "PCA_atlantic")
make_pca_and_plot(gl.coco.pacific, "PCA_pacific")

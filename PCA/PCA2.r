# jomare1188@gmail.com


library(tidyverse)
library(viridisLite)
library(ggsci)
library(RColorBrewer)
library(wesanderson)
library(vcfR)
library(adegenet)
library(ggrepel)


#####
# variables
wd = "/home/j/BIOINFORMATICA/POPULATIONS_GENOMICS/popstatistics/PCA2/"
setwd(wd)

#color=inferno(299)
#color=RColorBrewer::brewer.pal(11, "Spectral")
#color=RColorBrewer::brewer.pal(11, "RdYlGn")
#color=RColorBrewer::brewer.pal(11, "PiYG")
#color=viridis(20)
color=wes_palette("Zissou1", 100, type = "continuous")
#color=wes_palette("Darjeeling1", 100, type = "continuous")
#color=wes_palette("Chevalier1", 100, type = "continuous")

# make files
## add structure groups and heights
h <- read.table("heigh.csv", sep = ",", header = T)

c1 <- read.table("c1_ids.txt")
c1$class <- "c1"

c2 <- read.table("c2_ids.txt")
c2$class <- "c2"

c3 <- read.table("c3_ids.txt")
c3$class <- "c3"

c4 <-  read.table("c4_ids.txt")
c4$class <- "c4"

m <- read.table("mixed_ids.txt")
m$class <- "m"

pop <- read.table("popmap_ok.csv", sep = ",")
colnames(pop) <- c("ind", "Origin")

d_class<- rbind(c1,c2,c3,c4,m)
colnames(d_class) <- c("ind", "class")

# read files
vcf<-read.vcfR("no_mixed.recode.vcf")
gl.coco <- vcfR2genlight(vcf)
ploidy(gl.coco) <- 2

## make pca
coco.pca <- glPca(gl.coco, nf = 2, parallel = 1)
contrib<-100*coco.pca$eig/sum(coco.pca$eig)
#write.table(contrib, "./results/PCA_eigen_height.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = TRUE)
coco.pca.scores <- as.data.frame(coco.pca$scores)
coco.pca.scores$pop <- pop(gl.coco)
coco.pca.scores$ind <- rownames(coco.pca.scores)


## add heigh 
d <- coco.pca.scores
#d <- read.table("pca.csv" ,header = T, sep = ",")
df_height <- merge(d,h, by = "ind")
df_height$height <- df_height$height/100

# merge PCA with structure class and height
df_full <- merge(df_height, d_class, by = "ind")
d <- merge(df_full, pop, by = "ind")

# make plot
# labels
p <- ggplot(d, aes(x = PC1, y = PC2, shape = factor(Origin), color = height)) 
p <- p + geom_point(size=3.5, alpha = 1)
p <- p + labs(title = "", col="Height (m)", shape="Origin")
p <- p + xlab((paste0("PC1 : ",round(100 * (coco.pca$eig[1]/sum(coco.pca$eig)),2),"%")))
p <- p + ylab((paste0("PC2 : ",round(100 * (coco.pca$eig[2]/sum(coco.pca$eig)),2),"%")))
#p <- p + geom_text_repel(aes(label=ind), size=3.5, max.overlaps = 99 )
p <- p + scale_colour_gradientn(colours = color, limits=c(0, 20), breaks = seq(0,20,4))
p <- p + geom_hline(yintercept = 0) 
p <- p + geom_vline(xintercept = 0) 
p <- p + theme_bw()
p <- p + theme( text = element_text(family = "Times New Roman", size=22), 
                panel.border = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.line = element_line(colour = "black"))


p
ggsave(p, filename = "./PCA_nomixed_no_labels_height-Zissou1.png", units = "cm", width = 15*1.3, height = 15, dpi = 320)

# no labels
p <- ggplot(d, aes(x = PC1, y = PC2, shape = factor(Origin), color = height)) 
p <- p + geom_point(size=3.5, alpha = 0.9)
p <- p + labs(title = "", col="Height (m)", shape="Origin")
p <- p + xlab((paste0("PC1 : ",round(100 * (coco.pca$eig[1]/sum(coco.pca$eig)),2),"%")))
p <- p + ylab((paste0("PC2 : ",round(100 * (coco.pca$eig[2]/sum(coco.pca$eig)),2),"%")))
p <- p + scale_colour_gradientn(colours = inferno(299), limits=c(0, 20), breaks = seq(0,20,4))
p <- p + geom_hline(yintercept = 0) 
p <- p + geom_vline(xintercept = 0) 
p <- p + theme_bw()
p <- p + theme( text = element_text(family = "Times New Roman", size=22), 
                panel.border = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.line = element_line(colour = "black"))


p
ggsave( p, filename = "./PCA_nomixed_height_spectral.png",units = "cm",width = 15*1.3, height = 15,dpi = 320)

# by c1 c2 c3 c4

p <- ggplot(d, aes(x = PC1, y = PC2, shape = factor(class), color = height)) 
p <- p + geom_point(size=3.5, alpha = 0.9)
p <- p + labs(title = "", col="Height (m)", shape="Structure group")
p <- p + xlab((paste0("PC1 : ",round(100 * (coco.pca$eig[1]/sum(coco.pca$eig)),2),"%")))
p <- p + ylab((paste0("PC2 : ",round(100 * (coco.pca$eig[2]/sum(coco.pca$eig)),2),"%")))
p <- p + geom_text_repel(aes(label=ind), size=3.5, max.overlaps = 99 )
p <- p + scale_colour_gradientn(colours = inferno(299), limits=c(0, 20), breaks = seq(0,20,4))
p <- p + geom_hline(yintercept = 0) 
p <- p + geom_vline(xintercept = 0) 
p <- p + theme_bw()
p <- p + theme( text = element_text(family = "Times New Roman", size=22), 
                panel.border = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.line = element_line(colour = "black"))


p
ggsave( p, filename = "./PCA_nomixed_labels_height_structure_groups.png",units = "cm",width = 15*1.3, height = 15,dpi = 320)


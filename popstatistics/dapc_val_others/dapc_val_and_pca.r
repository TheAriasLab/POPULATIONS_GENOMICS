# Script for make the popstatistics calculations for Cocos nucifera GBS
# 18/march/2019
# For laboratorio de biologia comparativa 
# Jorge Mario Muñoz Pérez
library(adegenet)
library(hierfstat)
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(ggplot2)
library(igraph)

popid<-read.table("pops_id_full")
cols=c("blue","yellow","red","purple","green")

### geneligh####
vcf_test<-read.vcfR("stacks_p5.vcf")
gl.coco <- vcfR2genlight(vcf_test)
ploidy(gl.coco) <- 2
pop(gl.coco) <- popid[,3]
# DAPC
coco.dapc <- dapc(gl.coco, n.pca = 39, n.da = 2)
  png("./results/DAPC_leg", width = 800, height = 600)
par(family = "Times New Roman",cex=1,4)
        scatter(coco.dapc, cex = 3, legend = TRUE, clabel = F, scree.pca = TRUE,
        posi.pca = "bottomleft", ratio.pca = 0.25, cleg = 1.6, col=cols, posi.leg="topleft",pch=c(16, 17, 18, 15, 25))
dev.off()

## PCA GENELIGHT
# PCA EIGENVALUES
  coco.pca <- glPca(gl.coco, nf = 2,parallel = 4)
contrib<-100*coco.pca$eig/sum(coco.pca$eig)
write.table(contrib, "./results/PCA_eigen.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = TRUE)
coco.pca.scores <- as.data.frame(coco.pca$scores)
coco.pca.scores$pop <- pop(gl.coco)
cols=c("blue","yellow","red","purple","green")
library(ggplot2)
set.seed(9)
p <- ggplot(coco.pca.scores, aes(x=PC1, y=PC2, colour=pop, shape=pop)) 
p <- p + geom_point(size=4.5)
p <- p + stat_ellipse(level = 0.95, size = 0.5)
p <- p + scale_color_manual(values = cols) 
p <- p + geom_hline(yintercept = 0) 
p <- p + geom_vline(xintercept = 0) 
p <- p + theme_bw()
p <- p + theme( text = element_text(family = "Times New Roman", size=22), 
                panel.border = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.line = element_line(colour = "black"))
png("./ind_PCA_2PCA", width = 800, height = 600)
p
dev.off()



## MINIMUM SPANINNING TREE
#coco.dist <- bitwise.dist(gl.coco)
#coco.msn <- poppr.msn(gl.coco, coco.dist, showplot = FALSE, include.ties = T)

#node.size <- rep(3, times = nInd(gl.coco)) # rep 1 porque son snps
#names(node.size) <- indNames(gl.coco)
#vertex.attributes(coco.msn$graph)$size <- node.size

#set.seed(973)
#png("./results/Minimun_Spanning_Network", width = 800, height = 600)
#par(family = "Times New Roman",cex=1.1)
#plot_poppr_msn(gl.coco, coco.msn , palette = cols , name = "cols", gadj = 70, size.leg = FALSE, gscale=TRUE)
#dev.off()


# CROSS VALIDATION DAPC
#set.seed(999)

#png("./results/DAPC_Cross_validation_pca1_130", width = 800, height = 600)
#par(family = "Times New Roman",cex=1.5)
#dapcval <- xvalDapc(tab(gl.coco, NA.method = "mean"), pop(gl.coco),
#         n.pca = 1:130, n.rep = 100,
#         parallel = "multicore", ncpus = 8L)
#dev.off()

png("./results/DAPC_Cross_validation_pca20_60", width = 800, height = 600)
par(family = "Times New Roman",cex=1.5)
dapcval <- xvalDapc(tab(gl.coco, NA.method = "mean"), pop(gl.coco),
                    n.pca = 20:40, n.rep = 400,
                    parallel = "multicore", ncpus = 8L)
dev.off()


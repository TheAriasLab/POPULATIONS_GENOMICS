# Script for make the popstatistics calculations for Cocos nucifera GBS
# 12/march/2019
# For laboratorio de biologia comparativa 
# Jorge Mario Muñoz Pérez

library(adegenet)
library(hierfstat)

#popid<-read.table("pops_id")
popid<-read.table("pops_id_full")

#x <- read.genepop("stacks_p5.test.gen", ncode=2L)
x <- read.genepop("stacks_p5.gen", ncode=2L)

test_site<-genind2hierfstat(x,pop = popid[2])
test_region<-genind2hierfstat(x,pop = popid[1])

grupos_region<-c("Atlantic", "Pacific")
grupos_sites<-c("Antioquia", "Córdoba", "Nariño", "Cauca", "Chocó")

# popstats site
png("./Pop_stats_site", width = 800, height = 600)
par(family = "Times New Roman",cex=1.5)
basic_stats_site<-basic.stats(test_site)
boxplot(basic_stats_site$perloc)
dev.off()

# popstats region
png("./Pop_stats_region", width = 800, height = 600)
par(family = "Times New Roman",cex=1.5)
basic_stats_region<-basic.stats(test_region)
boxplot(basic_stats_region$perloc)
dev.off()

# FIS region
png("./global_FIS_region", width = 800, height = 600)
par(family = "Times New Roman",cex=1.5)
boxplot(basic_stats_region$Fis, main="Inbreeding coefficent Fis", xlab="Population", ylab="Fis", names=grupos_region) 
dev.off()
# FIS sites
png("./global_FIS_sites", width = 800, height = 600)
par(family = "Times New Roman",cex=1.5)
boxplot(basic_stats_site$Fis, main="Inbreeding coefficent Fis", xlab="Population", ylab="Fis", names=grupos_sites) 
dev.off()

# Ho sites
png("./global_Ho_sites", width = 800, height = 600)
par(family = "Times New Roman",cex=1.5)
boxplot(basic_stats_site$Ho, main="Observed Heterozigocity Ho", xlab="Population", ylab="Ho", names=grupos_sites) 
dev.off()
#Ho region
png("./global_Ho_region", width = 800, height = 600)
par(family = "Times New Roman",cex=1.5)
boxplot(basic_stats_region$Ho, main="Observed Heterozygozity Ho", xlab="Population", ylab="Ho", names=grupos_region) 
dev.off()
#Hs region
png("./global_Hs_region", width = 800, height = 600)
par(family = "Times New Roman",cex=1.5)
boxplot(basic_stats_region$Hs, main="Expected Heterozigocity Hs", xlab="Population", ylab="Hs", names=grupos_region) 
dev.off()
# Hs site
png("./global_Hs_site", width = 800, height = 600)
par(family = "Times New Roman",cex=1.5)
boxplot(basic_stats_site$Hs, main="Expected Heterozygozity Hs", xlab="Population", ylab="Hs", names=grupos_sites) 
dev.off()
#HoANT<-mean(basic_stats$Ho[,1])
#HoCOR<-mean(basic_stats$Ho[,2])
#HoNAR<-mean(basic_stats$Ho[,3])
#HoCAU<-mean(basic_stats$Ho[,4])
#HoCHO<-mean(basic_stats$Ho[,5])
#HsANT<-mean(basic_stats$Hs[,1])
#HsCOR<-mean(basic_stats$Hs[,2])
#HsNAR<-mean(basic_stats$Hs[,3])
#HsCAU<-mean(basic_stats$Hs[,4])
#HsCHO<-mean(basic_stats$Hs[,5])
#HoCAR<-mean(basic_stats$Ho[,1])
#HoPAC<-mean(basic_stats$Ho[,2])
#HsCAR<-mean(basic_stats$Hs[,1])
#HsPAC<-mean(basic_stats$Hs[,2])
#pairwise.neifst(test)
#pairwise.WCfst(test)

global_wc<-wc(x) # global fst y fis
write.table(global_wc$FST, "./WC_fst.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = FALSE)  
write.table(global_wc$FIS, "./WC_fis.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = FALSE)  

#matriz_comp<-varcomp.glob(test[,1],test[,-1])$loc # da más cosas, la diagonal debe dar igual a  wc

boot_fst_site<-boot.ppfst(test_site,nboot = 1000) # al parece si no esta en orden las poblaciones no funciona
write.table(boot_fst_site$ll, "./bs_fst_site_ll.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = FALSE)
write.table(boot_fst_site$ul, "./bs_fst_site_ul.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = FALSE)

boot_fst_region<-boot.ppfst(test_region,nboot = 1000) # al parece si no esta en orden las poblaciones no funciona
write.table(boot_fst_region$ll, "./bs_fst_region_ll.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = FALSE)
write.table(boot_fst_region$ul, "./bs_fst_region_ul.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = FALSE)

boot_fis_site<-boot.ppfis(test_site, nboot = 1000)
boot_fis_region<-boot.ppfis(test_region,nboot = 1000)
write.table(boot_fis_site$fis.ci, "./bs_fis_site.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = TRUE)
write.table(boot_fis_region$fis.ci, "./bs_fis_region.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = TRUE)

#boot.vc(test,test[,-1],nboot = 10)$ci
#fstNei_matrix <- pairwise.neifst(test) # fst matrix 
#fstWCfst_matrix <- pairwise.WCfst(test)

#PCOA mejor cambiarlo por alguno de esos arboles chimbas
#https://grunwaldlab.github.io/Population_Genetics_in_R/gbs_analysis.html

Ds<-genet.dist(x,method="Ds") # Nei's standard genetic distances
pcoa(as.matrix(Ds))
dev.off()
#Ind PCA
#install.packages("vcfR")
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)

### geneligh####

#vcf_test<-read.vcfR("test.vcf")
vcf_test<-read.vcfR("stacks_p5.vcf")

gl.coco <- vcfR2genlight(vcf_test)
ploidy(gl.coco) <- 2
pop(gl.coco) <- popid[,3]
## PCA GENELIGHT
# PCA EIGENVALUES
coco.pca <- glPca(gl.coco, nf = 3)
png("./PCA_Eigenvalues", width = 800, height = 600)
par(family = "Times New Roman",cex=1.4)
barplot(100*coco.pca$eig/sum(coco.pca$eig), col = "black", main="PCA Eigenvalues")
title(ylab="Percent of variance\nexplained", line = 2)
title(xlab="Eigenvalues", line = 1)
dev.off()

# PCA GRAPH
coco.pca.scores <- as.data.frame(coco.pca$scores)
coco.pca.scores$pop <- pop(gl.coco)
cols=c("blue","yellow","red","purple","green")
library(ggplot2)
set.seed(9)
p <- ggplot(coco.pca.scores, aes(x=PC1, y=PC2, colour=pop, shape=pop)) 
p <- p + geom_point(size=2)
p <- p + stat_ellipse(level = 0.95, size = 1)
p <- p + scale_color_manual(values = cols) 
p <- p + geom_hline(yintercept = 0) 
p <- p + geom_vline(xintercept = 0) 
p <- p + theme_bw()
p <- p + theme( text = element_text(family = "Times New Roman", size=22), 
                panel.border = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                axis.line = element_line(colour = "black"))
png("./ind_PCA", width = 800, height = 600)
p
dev.off()

## DAPC
# el DAPC es para compara con el PCA por lo que se va a hacer con los mismos datos del PCA
#coco.clusters <- find.clusters(gl.coco, max.n.clust=8,stat = "BIC",method = "ward")
#coco.clusters <- find.clusters(gl.coco, max.n.clust=8,stat = "AIC",method = "ward")
#coco.clusters <- find.clusters(gl.coco, max.n.clust=8,stat = "WSS",method = "ward")

#coco.clusters <- find.clusters(gl.coco, max.n.clust=8,stat = "BIC")
#coco.clusters <- find.clusters(gl.coco, max.n.clust=8,stat = "AIC")
#coco.clusters <- find.clusters(gl.coco, max.n.clust=8,stat = "WSS")

coco.dapc <- dapc(gl.coco, n.pca = 3, n.da = 2)
png("./DAPC", width = 800, height = 600)
par(family = "Times New Roman",cex=1.4)
scatter(coco.dapc, cex = 2, legend = TRUE, clabel = F, posi.leg = "bottomleft", scree.pca = TRUE,
        posi.pca = "topleft", ratio.pca = 0.25, cleg = 1.2)
dev.off()

# CROSS VALIDATION DAPC
library("poppr")
#set.seed(999)

#png("./DAPC_Cross_validation_pca1_130", width = 800, height = 600)
#par(family = "Times New Roman",cex=1.5)
#dapcval <- xvalDapc(tab(gl.coco, NA.method = "mean"), pop(gl.coco),
#         n.pca = 1:130, n.rep = 1000,
#         parallel = "multicore", ncpus = 8L)
#dev.off()

#png("./DAPC_Cross_validation_pca1_5", width = 800, height = 600)
#par(family = "Times New Roman",cex=1.5)
#dapcval <- xvalDapc(tab(gl.coco, NA.method = "mean"), pop(gl.coco),
#                    n.pca = 1:5, n.rep = 1000,
#                    parallel = "multicore", ncpus = 8L)
#dev.off()

# pensar en la idea de no poner el table ese que no dice nada y mejor un compoplot por departamento
#install.packages("igraph")
library(igraph)

coco.dist <- bitwise.dist(gl.coco)
coco.msn <- poppr.msn(gl.coco, coco.dist, showplot = FALSE, include.ties = T)

node.size <- rep(4, times = nInd(gl.coco))
names(node.size) <- indNames(gl.coco)
vertex.attributes(coco.msn$graph)$size <- node.size

set.seed(1235)
png("./Minimun_Spanning_Network", width = 800, height = 600)
par(family = "Times New Roman",cex=1.2)
plot_poppr_msn(gl.coco, coco.msn , palette = cols , name = "cols", gadj = 70)
dev.off()

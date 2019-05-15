library(adegenet)
library(hierfstat)
# Script for make the popstatistics calculations for Cocos nucifera GBS
# 19/march/2019
# Jorge Mario Muñoz Pérez

popid<-read.table("pops_id_full")
x <- read.genepop("stacks_p5.gen", ncode=2L)

test_site<-genind2hierfstat(x,pop = popid[2])
test_region<-genind2hierfstat(x,pop = popid[1])

grupos_region<-c("Atlantic", "Pacific")
grupos_sites<-c("Antioquia", "Córdoba", "Nariño", "Cauca", "Chocó")
cols=c("blue","yellow","red","purple","green")

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

global_wc<-wc(x) # global fst y fis
write.table(global_wc$FST, "./WC_fst.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = FALSE)  
write.table(global_wc$FIS, "./WC_fis.txt", append = FALSE, sep = " ", dec = ".", row.names = FALSE, col.names = FALSE)  

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

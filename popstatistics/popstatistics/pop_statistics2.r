popstatistics<-function(genepop,popfile,bootstraps,out,popgrouping){ 
  install.packages("adegenet","hierfstats")
  library(adegenet)
  library(hierfstat)
  popid<-read.table(popfile)
  x <- read.genepop(genepop, ncode=2L)
  test<-genind2hierfstat(x,pop = popid[2])
  #grupos<-c("Atlantic", "Pacific")
  grupos<-c("Antioquia", "Córdoba", "Nariño", "Cauca", "Chocó")
  par(family = "Times New Roman")
  # popstats
  basic_stats<-basic.stats(test)
  boxplot(basic_stats$perloc)
  png(out+"/global_FIS_sites", width = 800, height = 600)
  par(family = "Times New Roman")
  boxplot(basic_stats$Fis, main="Inbreeding coefficent Fis", xlab="Population", ylab="Fis", names=grupos, cex=1.2) 
  dev.off()

  png(out+"/global_Ho_sites", width = 800, height = 600)
  par(family = "Times New Roman")
  boxplot(basic_stats$Ho, main="Observed Heterozigocity Ho", xlab="Population", ylab="Ho", names=grupos, cex=1.2) 
  dev.off()

  png(out+"/global_Hs_sites", width = 800, height = 600)
  par(family = "Times New Roman")
  boxplot(basic_stats$Hs, main="Expected Heterozigocity Hs", xlab="Population", ylab="Hs", names=grupos, cex=1.2) 
  dev.off()

  png(out+"/Ho_site", width = 800, height = 600)
  par(family = "Times New Roman")
  boxplot(basic_stats$Ho, main="Observed Heterozygozity Ho", xlab="Population", ylab="Ho", names=c("Antioquia","Córdoba", "Nariño", "Cauca", "Chocó")) 
  dev.off()

  png(out+"/Hs_site", width = 800, height = 600)
  par(family = "Times New Roman")
  boxplot(basic_stats$Hs, main="Expected Heterozygozity Hs", xlab="Population", ylab="Hs", names=c("Antioquia","Córdoba", "Nariño", "Cauca", "Chocó")) 
  dev.off()

  HoANT<-mean(basic_stats$Ho[,1])
  HoCOR<-mean(basic_stats$Ho[,2])
  HoNAR<-mean(basic_stats$Ho[,3])
  HoCAU<-mean(basic_stats$Ho[,4])
  HoCHO<-mean(basic_stats$Ho[,5])
  HsANT<-mean(basic_stats$Hs[,1])
  HsCOR<-mean(basic_stats$Hs[,2])
  HsNAR<-mean(basic_stats$Hs[,3])
  HsCAU<-mean(basic_stats$Hs[,4])
  HsCHO<-mean(basic_stats$Hs[,5])

#HoCAR<-mean(basic_stats$Ho[,1])
#HoPAC<-mean(basic_stats$Ho[,2])
#HsCAR<-mean(basic_stats$Hs[,1])
#HsPAC<-mean(basic_stats$Hs[,2])

pairwise.fst(, pop = as.matrix(popid), res.type = "matrix")
wc(x) # global fst y fis
matriz_comp<-varcomp.glob(test[,1],test[,-1])$loc # da más cosas, la diagonal debe dar igual a  wc
boot.ppfst(test[-c(1)],nboot = 10) # al parece si no esta en orden las poblaciones no funciona
boot.ppfis(test[-c(1)],nboot = 10)
boot.vc(test[,1],test[,-1])$ci
fst_matrix <- pairwise.fst(x, res.type = "matrix") # fst matrix 
}
popstatistics("./populations.snps.gen","./popfile_for_R",1000,"./",2)


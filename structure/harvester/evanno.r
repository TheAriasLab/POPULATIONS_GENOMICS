# R script for apply method Evanno et al. (2005) for choose numbers of clusters k
# March 4 2019 for Laboratorio de biologia comparativa CIB
# by Jorge Mario Muñoz Pérez
# input table from summary.txt made by harvestesr.py this table is given by the bash script that calls this one
 evanno<-function(input,output){ 
  data<-read.table(input,header=FALSE,sep= "\t")
  dLnK <- matrix(nrow=length(data[,1]), ncol=1)
  d2LnK <- matrix(nrow=length(data[,1]), ncol=1)
  for (i in seq(length(data[,1]))) {
    dLnK[i+1]<--data[(i+1),3]+data[i,3]
  }
  for (i in seq(length(data[,1]))) {
    d2LnK[i,1]<--dLnK[(i+1)]+dLnK[(i)]  
  }
  deltak<-d2LnK/data[,4]
  k<-c(1,2,3,4,5,6)
  png(output, width = 800, height = 600)
  par(family = "Times New Roman",cex=1.7)
  plot(k,abs(deltak),ylab="Delta K",xlab="K", main="Evanno Method, Delta K = |Ln''(K)| * sd(Ln(K))", pch=19)
  lines(k,abs(deltak))
  dev.off()
}
evanno("./for_calculate_deltak.txt","./evanno.png")

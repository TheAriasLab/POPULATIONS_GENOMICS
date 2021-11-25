# USo coco lite osea snps sin ld y aclandos a cromosomas para hallar hibridos usando la funcion 
# snapcluste de adegenet en modo k= 2 y hybrids TRUE

library(dartR)
library(vcfR)
library(ggplot2)
library(dplyr)
library(wesanderson)

cols=wes_palette("Zissou1", 3, type = "continuous")


vcf<-read.vcfR("/home/j/BIOINFORMATICA/POPULATIONS_GENOMICS/popstatistics/PCA2/coco_lite.vcf")


dat<-vcfR2genind(vcf)
hyb <- snapclust(dat, k = 2, hybrids = TRUE)
df <- as.data.frame(hyb$proba)
colnames(df) <- c("Pure_A", "Pure_B", "Hybrids")
df <- df %>% mutate(Ind = rownames(df))


#dat<-read.table("snapclust_for_graph_in_R.csv",sep = ",",header=TRUE)
df2 <- rbind(
  data.frame("Individual"=factor(df$Ind), "Probability" = df$Pure_A, "Group"="Pure A"),
  data.frame("Individual"=factor(df$Ind), "Probability" = df$Pure_B, "Group"="Pure B"),
  data.frame("Individual"=factor(df$Ind), "Probability" = df$Hybrids, "Group"="Hybrids")
  
)


ggplot(df2, aes(x=Individual, y=Probability, fill=Group)) +
  geom_bar(stat="identity")+
  theme_bw()+
  scale_x_discrete(breaks= df$Ind )+
  scale_fill_manual(values = cols)+
  theme( text = element_text(family = "Times New Roman", size=22), 
         panel.border = element_blank(),
         panel.grid.major = element_blank(),
         panel.grid.minor = element_blank(),
         axis.line = element_line(colour = "black"),
         axis.text.x = element_text(angle=90, size=12, colour = "black"),
         plot.title = element_text(hjust = 0.5))


ggsave(filename = "./snapclust.png",units = "cm",width = 45, height = 15,dpi = 320)

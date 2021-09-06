library(tidyverse)
library(viridisLite)
palette <- inferno(299)
wd = "/home/j/BIOINFORMATICA/POPULATIONS_GENOMICS/popstatistics/fst/"
setwd(wd)
d <- read.table("out.weir.fst", header = T)
atl <- read.table("snp_id_atlantic.txt", header = F)
pac <- read.table("snp_id_pacific.txt", header = F)
all <- read.table("snp_all.txt", header = F)

d$id <-all$V1

common <- intersect(atl,pac)
common$class <- "Common atlantic-pacific"
atl_exc <- setdiff(atl,pac)
atl_exc$class <- "Atlantic"
pac_exc <- setdiff(pac,atl)
pac_exc$class <- "Pacific"
differentiating <- setdiff(all , union(pac,atl))
differentiating$class <- "Differenciating"


data <- rbind(atl_exc,common,pac_exc,differentiating)
colnames(data) <- c("id", "Group")


df <- merge(d,data, by = "id")


write.csv(x = df ,file = "data_for_fst.csv", row.names = F)
c1 <- df %>% filter(CHROM=="CM017872.1") %>% mutate(POS = POS/max(POS)+1) 
c2 <- df %>% filter(CHROM=="CM017873.1") %>% mutate(POS = POS/max(POS)+2) 
c3 <- df %>% filter(CHROM=="CM017874.1") %>% mutate(POS = POS/max(POS)+3) 
c4 <- df %>% filter(CHROM=="CM017875.1") %>% mutate(POS = POS/max(POS)+4) 
c5 <- df %>% filter(CHROM=="CM017876.1") %>% mutate(POS = POS/max(POS)+5) 
c6 <- df %>% filter(CHROM=="CM017877.1") %>% mutate(POS = POS/max(POS)+6) 
c7 <- df %>% filter(CHROM=="CM017878.1") %>% mutate(POS = POS/max(POS)+7) 
c8 <- df %>% filter(CHROM=="CM017879.1") %>% mutate(POS = POS/max(POS)+8) 
c9 <- df %>% filter(CHROM=="CM017880.1") %>% mutate(POS = POS/max(POS)+9) 
c10 <- df %>% filter(CHROM=="CM017881.1") %>% mutate(POS = POS/max(POS)+10) 
c11 <- df %>% filter(CHROM=="CM017882.1") %>% mutate(POS = POS/max(POS)+11) 
c12 <- df %>% filter(CHROM=="CM017883.1") %>% mutate(POS = POS/max(POS)+12) 
c13 <- df %>% filter(CHROM=="CM017884.1") %>% mutate(POS = POS/max(POS)+13) 
c14 <- df %>% filter(CHROM=="CM017885.1") %>% mutate(POS = POS/max(POS)+14) 
c15 <- df %>% filter(CHROM=="CM017886.1") %>% mutate(POS = POS/max(POS)+15) 
c16 <- df %>% filter(CHROM=="CM017887.1") %>% mutate(POS = POS/max(POS)+16) 

data <- rbind(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16)
 
p <- ggplot(data, aes(x = POS, y=WEIR_AND_COCKERHAM_FST,color=Group)) +
scale_x_continuous(breaks=seq(1, 16, 1)) +
geom_point()+
xlab("Chromosome")+
ylab("Fst")+
theme_bw()+
theme(text = element_text(family = "Times New Roman", size=22), 
              panel.border = element_blank(),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              axis.line = element_line(colour = "black")) 


 #ggsave(p,  filename = "./fst.png",units = "cm",width = 15*4, height = 15,dpi = 320)
p

atlantic_fst_venn <- filter(df, Group == "Atlantic") %>% select(WEIR_AND_COCKERHAM_FST)
pacific_fst_venn <- filter(df, Group == "Pacific") %>% select(WEIR_AND_COCKERHAM_FST) 
common_fst_venn <- filter(df, Group == "Common atlantic-pacific") %>% select(WEIR_AND_COCKERHAM_FST) 
differenting_fst_venn <- filter(df, Group == "Differenciating") %>% select(WEIR_AND_COCKERHAM_FST) 

mean(df$WEIR_AND_COCKERHAM_FST, na.rm = T)
mean(atlantic_fst_venn$WEIR_AND_COCKERHAM_FST, na.rm = T)
mean(pacific_fst_venn$WEIR_AND_COCKERHAM_FST, na.rm = T)
mean(common_fst_venn$WEIR_AND_COCKERHAM_FST, na.rm = T)
mean(differenting_fst_venn$WEIR_AND_COCKERHAM_FST, na.rm = T)

pi_c1 <- read.table("pi_c1_maf.sites.pi", header = T)
pi_c2 <- read.table("pi_c2_maf.sites.pi", header = T)
pi_c3 <- read.table("pi_c3_maf.sites.pi", header = T)
pi_c4 <- read.table("pi_c4_maf.sites.pi", header = T)
pi_m <- read.table("pi_mixed_maf.sites.pi", header = T)

D1 <- read.table("Tajima_c1_maf.Tajima.D", header = T)
D2 <- read.table("Tajima_c2_maf.Tajima.D", header = T)
D3 <- read.table("Tajima_c3_maf.Tajima.D", header = T)
D4 <- read.table("Tajima_c4_maf.Tajima.D", header = T)
Dm <- read.table("Tajima_mixed_maf.Tajima.D", header = T)

mean(pi_c1$PI)
mean(pi_c2$PI)
mean(pi_c3$PI, na.rm = T)
mean(pi_c4$PI, na.rm = T)
mean(pi_m$PI)
weighted.mean(D1$TajimaD, na.rm = T)
weighted.mean(D2$TajimaD, na.rm = T)
weighted.mean(D3$TajimaD, na.rm = T)
weighted.mean(D4$TajimaD, na.rm = T)
weighted.mean(Dm$TajimaD, na.rm = T)




pi_pacific <-  read.table("pi_pacific.sites.pi", header = T)
mean(pi_pacific$PI)

Tatl <- read.table("Tajima_atlantic.Tajima.D", header = T)
wmeanTatl <-  weighted.mean(Tatl$TajimaD, Tatl$N_SNPS)
wmeanTatl
Tpc <-read.table("Tajima_pacific.Tajima.D", header = T)
wmeanTpc <-  weighted.mean(Tpc$TajimaD, Tpc$N_SNPS)
wmeanTpc


pi_atlantic <- read.table("pi_c1_maf.sites.pi", header = T)
mean(pi_atlantic$PI)


wd ="/home/j/BIOINFORMATICA/POPULATIONS_GENOMICS/structure/distruct/"
library(tidyverse)
setwd(wd)
d <- read.table("K4.ind.clumpp.out.csv", header = T)

c1 <- filter(d, c1 >= 0.6) %>% select(ind)
c2 <- filter(d, c2 >= 0.6) %>% select(ind)
c3 <- filter(d, c3 >= 0.6) %>% select(ind)
c4 <- filter(d, c4 >= 0.6) %>% select(ind)


m <- filter(d, c1 < 0.6, c2 < 0.6, c3 < 0.6, c4 < 0.6) %>% select(ind)


atlantic <- c4
pacific <- rbind(c1,c2)

write.table(c1, "c1_ids.txt", quote = F, row.names = F, col.names = F)
write.table(c2, "c2_ids.txt", quote = F, row.names = F, col.names = F)
write.table(c3, "c3_ids.txt", quote = F, row.names = F, col.names = F)
write.table(c4, "c4_ids.txt", quote = F, row.names = F, col.names = F)
write.table(m, "mixed_ids.txt", quote = F, row.names = F, col.names = F)
write.table(pacific, "pacific_ids.txt", quote = F, row.names = F, col.names = F)
write.table(atlantic, "atlantic_ids.txt", quote = F, row.names = F, col.names = F)

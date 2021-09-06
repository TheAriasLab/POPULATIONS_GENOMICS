# Script for plot LD decay calculated by PopLDdecay for structure groups c1, c2, c3, c4.# Script for plot LD decay calculated by PopLDdecay for structure groups c1, c2, c3, c4.
library(tidyverse)
library(viridisLite)
colors = c("red","#000004FF", "#781C6DFF", "#ED6925FF", "yellow", "darkgreen")
wd = "/home/j/BIOINFORMATICA/POPULATIONS_GENOMICS/popstatistics/LD/all/all/"
setwd(wd)
read.table("all.c1")->c1
read.table("all.c2")->c2
read.table("all.c3")->c3
read.table("all.c4")->c4
read.table("all.all")->all
read.table("all.pacific")->pacific

get_LD <- function (Distance, Rsquared, n, rho.start, group) {
hill.weir.eq=(Rsquared~(((10+(rho*Distance))/((2+(rho*Distance))*(11+(rho*Distance))))*(1+(((3+(rho*Distance))*(12+(12*(rho*Distance))+((rho*Distance)**2)))/(n*(2+(rho*Distance))*(11+(rho*Distance)))))))
m=nls(formula=hill.weir.eq, start=list(rho=rho.start))
results.m=summary(m)
cor(Rsquared, predict(m))
rho.estimate=results.m$parameters[1]
Distance=sort(Distance)
exp.rsquared=(((10+(rho.estimate*Distance))/((2+(rho.estimate*Distance))*(11+(rho.estimate*Distance))))*(1+(((3+(rho.estimate*Distance))*(12+(12*(rho.estimate*Distance))+((rho.estimate*Distance)**2)))/(n*(2+(rho.estimate*Distance))*(11+(rho.estimate*Distance))))))
return(output = data.frame(R_2 = exp.rsquared, Distance = Distance, group = group, points = Rsquared))
}

c1_smooth <- get_LD(c1$V1, c1$V2, 16, -0.000000001, "c1")
c2_smooth <- get_LD(c2$V1, c2$V2, 35, 0.00001, "c2")
c3_smooth <- get_LD(c3$V1, c3$V2, 5, 0.00001, "c3")
c4_smooth <- get_LD(c4$V1, c4$V2, 29, 0.00001, "c4")
all_smooth <- get_LD(all$V1, all$V2, 112, 0.00001, "all")
pacific_smooth <- get_LD(pacific$V1, pacific$V2, 51, 0.00001, "pacific")

df <- rbind(c1_smooth, c2_smooth, c3_smooth, c4_smooth, all_smooth, pacific_smooth)
df %>% mutate(Distance = Distance/(10**6)) -> df
p <- ggplot(data = df)  +
geom_line(aes(x=Distance, y=R_2, color = group),  alpha = 1, size = 1.5)+
geom_point(aes(x=Distance, y=points, color = group),  alpha =0.5, size = 2)+
labs(x="Distance (Megabases)",y=expression(LD~(r^{2})))+
labs(title = "", col="Group")+
scale_color_manual(values = colors) +
theme_bw()+
theme( text = element_text(family = "Times New Roman", size=22),
panel.border = element_blank(),
panel.grid.major = element_blank(),
panel.grid.minor = element_blank(),
axis.line = element_line(colour = "black"))
p
ggsave( p, filename = "LD_suave.png",units = "cm",width = 15*1.6, height = 15,dpi = 320)


library(tidyverse)
data("diamonds")
library(ggimage)
str(diamonds)
library(magick)
library(forcats)
library(ggimage)

library(cowplot)

system
diamonds$im <- "./are-diamonds-a-good-investment.jpg"


P <- ggplot(diamonds, aes(x=z, y=table, image=im))+
  geom_point(method="lm")

ggdraw() + 
  draw_label("Diamonds", color = "#C0A0A0", size = 110, angle =210 ) +
  draw_plot(
    p + theme_half_open(15))  

img <-"./are-diamonds-a-good-investment.jpg"


p <- ggplot(diamonds, aes(x=z, y=table, color=price, size=carat, shape=color))+
  geom_point(size=0.7) + 
  scale_fill_grey() +
  coord_cartesian(expand = FALSE)+
  theme_minimal_hgrid(11, color = "grey30")+ scale_x_continuous(name = "z", limits = c(0,15))+
  scale_y_continuous(name = "table", limits = c(50,80))+
  theme(plot.title = element_text(size=35,colour = "green",face = "bold", angle = 170, hjust = 0.7), 
        legend.position="top",legend.background = element_rect(fill = "darkgray"),
        legend.title=element_blank(),
        axis.line = element_line(color="red",size = 5,linetype = "dotted"),
        legend.key = element_rect(fill = "red", color = NA),
        axis.text.x =element_text(face="bold", color="#E69F00",angle = 145,size = 25),
        axis.text.y =element_text(face="bold", color="#74d5f2",angle = 180,size = 35),
        axis.title.y=element_blank())+
  labs(title = "BLING_BLING",subtitle = "DIAmonds",tag = "By_Joscif Raigne", 
       x= "Z_valUe", y= "TaBle", fill="PRICE OF DIAMOND")

p <- p + facet_wrap( ~ clarity, ncol=3, nrow = 3)

 p
u <- p+guides(fill = guide_colourbar(label.theme = element_text(colour = "blue", angle = 0)))
ggdraw() + 
  draw_image(img, x = 0.1, y = -0.3, width = 1, height = 2, scale = 1.5,
             clip = "on", interpolate = T, hjust = 0, vjust = 0.1) + 
  draw_plot(p)

ggsave("./UGLY_BLING_RAIGNE.png", device="png",dpi=200)





d <- data.frame(x = rnorm(10),
                y = rnorm(10),
                image = sample(c("https://www.r-project.org/logo/Rlogo.png",
                                 "https://jeroenooms.github.io/images/frink.png"),
                               size=10, replace = TRUE)
)
ggplot(d, aes(x, y)) + geom_image(aes(image=image), size=.05)

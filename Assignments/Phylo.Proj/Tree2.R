library(Biostrings)
library(ggplot2)
library(ape)
library(tidyverse)
library(ggtree)



tree<- read.tree("./TREE/ORY_R_tree.nwk")

#visualize tree
tree1 <- ggtree(tree, branch.length='none',root.position =44, size=2)+
  geom_tiplab(align = TRUE, linesize = 0.5)+ 
  geom_text(aes(label=node))+
  coord_cartesian(clip = 'off') + 
  theme_tree2(plot.margin=margin(6, 240, 6, 6))
tree1

ggtree(tree)+ ggtitle("tree")
# We see that cultivars are distorting tree between #16 and 15 and again 8 and 13.
# all nodes will be collapsed that contain Oryza sativa cultivars, except the H1 isolate.



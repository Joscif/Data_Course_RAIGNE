library(msa)
library(phangorn)
library(ape)
library(tidyverse)
library(ggtree)
#fastafiles <- list.files("./DATA_PROJECT/",pattern="fasta",full.names = TRUE)
seqs <- readDNAStringSet("./DATA_PROJECT/cleaned_aligned_oryza(final).fas")


?msa()


alignment <- msa(seqs[1:45])
alignment


#convert to phangorn format
phydat <- msaConvert(alignment,type="phangorn::phyDat")
# move on to phangorn example walthrough linked above
dm <- dist.ml(phydat)
treeUPGMA  <- upgma(dm)
treeNJ  <- NJ(dm)
layout(matrix(c(1,2), 2, 1), height=c(1,2))
par(mar = c(0,0,2,0)+ 0.1)
plot(treeUPGMA, main="UPGMA")

# Maximum likelihood

data(phydat)
#dm <- dist.logDet(phydat)
dna <- dist.dna(phydat)
tree <- NJ(dm)
# NJ
set.seed(123)
NJtrees <- bootstrap.phyDat(phydat, FUN=function(x)NJ(dist.logDet(x)), bs=100)
treeNJ <- plotBS(tree, NJtrees, "phylogram")
treeNJ

# Maximum likelihood

fit <- pml(tree, phydat)
fit <- optim.pml(fit, rearrangement="NNI")
set.seed(123)
bs <- bootstrap.pml(fit, bs=800, optNni=TRUE)
dst <- 
treeBS <- plotBS(fit$tree,bs)

ggtree(fit$tree, mrsd="2013-01-01",root.position =58, branch.length='none')+
  geom_text(aes(label=node))+
  geom_tiplab(align = TRUE, linesize = 0.5)
 

(phydat,model = "T92")
?dist.ml()
?dist.log
?xlim_tree()
                    
                    
#https://www.molecularecologist.com/2017/02/phylogenetic-trees-in-r-using-ggtree/
TR <- ggtree(treeUPGMA, mrsd="2013-01-01")+
  geom_tiplab(align = TRUE, linesize = 0.5)
xlim_tree(3000)

ggtree(treeUPGMA, layout="circular", mrsd="2013-01-01")+
  geom_tiplab(align = TRUE, linesize = 0.5)+
  theme_tree2()
TR
TR+coord_cartesian(clip = 'off') + 
  theme_tree2(plot.margin=margin(6, 120, 6, 6))

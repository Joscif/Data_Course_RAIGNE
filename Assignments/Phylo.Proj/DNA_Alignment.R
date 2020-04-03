library(msa)
library(phangorn)
library(ape)
fastafiles <- list.files("./DATA_PROJECT/",pattern="fasta",full.names = TRUE)
seqs <- readDNAStringSet(fastafiles)


?msa()


alignment <- msa(seqs[1:39])
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

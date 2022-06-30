library(indicspecies)
pc=read.csv("Indicator_species_data.txt", header=TRUE,sep="\t")
abund = pc[,4:ncol(pc)]
Chemotype = pc$Chemotype
inv = multipatt(abund, Chemotype, func = "r.g", control = how(nperm=9999))
summary(inv)

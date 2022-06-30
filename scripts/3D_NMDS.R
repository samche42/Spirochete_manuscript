library(vegan)
abund = read.csv("ANOSIM_data.txt", header= TRUE, sep="\t")

#make community matrix - extract columns with abundance information
nums = abund[,3:ncol(abund)]

#turn abundance data frame into a matrix
nums_matrix = as.matrix(nums)

set.seed(123)
nmds = metaMDS(nums_matrix, k=3, distance = "bray")

#extract NMDS scores (x and y coordinates)
data.scores = as.data.frame(scores(nmds))

#add columns to data frame 
data.scores$Source = abund$Species
data.scores$Sample = abund$Sample
 
data.scores

#Load up libraries
library(plotly)

#Generate plot
plot_3D <- plot_ly(data.scores, x = ~NMDS1, y = ~NMDS2, z = ~NMDS3, color = ~Species, marker = list(size = 5), text = ~paste('<br>Species:', Species, '<br>Sample:', Sample)) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'NMDS1'),
                     yaxis = list(title = 'NMDS2'),
                     zaxis = list(title = 'NMDS3')))
#Show plot
plot_3D

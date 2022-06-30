#Load package and our data
library(vegan)
all_data = read.csv("ANOSIM_data.txt", header=TRUE, sep ="\t")

#Find unique groups in data
groups = unique(all_data[c("Species")])
group_list = as.list(groups$Species)

#Calculate pairwise ANOSIM statistics
for (i in group_list) {
	for (j in group_list) {
	if (i==j) next
	sub_df1 = subset(all_data, subset=(Species==i))
	sub_df2 = subset(all_data, subset=(Species==j))
	sub_df = rbind(sub_df1, sub_df2)
	nums = sub_df[,3:ncol(sub_df)]
	nums_matrix = as.matrix(nums)
	set.seed(123)
	ano = anosim(nums_matrix, sub_df$Species, distance = "bray", permutations = 9999)
	Rvalue = ano$statistic
	pvalue = ano$signif
	cat(i," \t ",j ,"\t R-value: ", Rvalue, "\t P-value: \t", pvalue, '\n')

	}
}

library(gplots)

setwd("/Users/dwhong/Desktop/R_code/heatmap")

a <- read.table('gene_expressions.csv',sep=',',stringsAsFactors = F,header=T, row.names=1)

sample_color <- c(rep("#FF0000",497),rep("#0000FF",52))
a <- a[rownames(a)%in%c('TAT', 'B3GNT6', 'OGT', 'MAT2A', 'UGDH', 'SCD', 'LAP3', 'PIGW', 'PFKFB4', 'NDUFB11', 'DHCR7', 'POLR2G', 'POLR3E', 'B3GAT2', 'RRM2', 'ADCY10', 'AK2', 'GLO1', 'FLAD1', 'ENGASE'),]

pval <- c(0.)
pdf('heatmap.pdf', width = 7,height = 7)
heatmap.2(data.matrix(a), col=bluered(100), scale = 'row', ColSideColors=sample_color, Colv=TRUE, Rowv = TRUE, dendrogram = "both", cexRow = 0.90,
          srtCol=45,  adjCol = c(1,1), srtRow=0, adjRow=c(0, 1),
          key=TRUE, keysize = 1, key.title = NA,symkey=FALSE, density.info="none", trace="none",,na.color="black")
dev.off()


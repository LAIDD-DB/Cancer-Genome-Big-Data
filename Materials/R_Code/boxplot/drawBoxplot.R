library(ggplot2)

setwd("/Users/dwhong/Desktop/R_code/boxplot")

iFILE <- "gene_expressions.csv"
gNAME <- "OGT"

data <-read.table(iFILE, sep = ',', stringsAsFactors = F, header = F, row.names = 1)
iDATA <- data.frame(cbind(t(data[rownames(data)%in%c(gNAME),]), t(data[1,])))
names(iDATA) <- c('value','type')
iDATA$value <- as.double(levels(iDATA$value))[iDATA$value]
iDATA$type <- toupper(iDATA$type)
iDATA$type <- gsub("_"," ",iDATA$type)

pdf(paste0(gNAME,".pdf"))
ggplot(iDATA,aes(type,value)) + geom_boxplot(aes(fill = type)) +
  xlab("") +
  ylab(paste0(gNAME,", mRNA Expression (RNA Seq V2 RSEM)")) +
  ggtitle("") +
  guides(fill = F) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.5, size = 12, face = "bold"), axis.title.y = element_text(size = 16, face = "bold"))
invisible(dev.off())

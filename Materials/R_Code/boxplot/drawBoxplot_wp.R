library(ggplot2)

setwd("/Users/dwhong/Desktop/R_code/boxplot")

iFILE <- "gene_expressions.csv"
gNAME <- "OGT"

data <-read.table(iFILE, sep = ',', stringsAsFactors = F, header = F, row.names = 1)
iDATA <- data.frame(cbind(t(data[rownames(data)%in%c(gNAME),]), t(data[1,])))
names(iDATA) <- c('value','type')
iDATA$value <- log2(as.double(levels(iDATA$value))[iDATA$value])
#iDATA$value <- as.double(levels(iDATA$value))[iDATA$value]
iDATA$type <- toupper(iDATA$type)
iDATA$type <- gsub("_"," ",iDATA$type)

#nor <- 
#tur <- 
#pVal <- 

iMin <- min(nor,tur)
iMax <- max(nor,tur)
iMax <- round(iMax + (iMax/20), 1)
interval <- round((iMax - iMin)/5, 1)

pdf(paste0(gNAME,"_pvalue.pdf"))
ggplot(iDATA,aes(type,value)) + geom_boxplot(aes(fill = type)) +
  geom_segment(aes(x = 2, y = iMax-(interval*0.2), xend = 2, yend = iMax)) +
  geom_segment(aes(x = 1, y = iMax-(interval*0.2), xend = 1, yend = iMax)) +
  geom_segment(aes(x = 1, y = iMax, xend = 2, yend = iMax)) +
  geom_text(aes(x = 1.5, y = iMax + (interval*0.15), label = paste0("*p-value = ",pVal)), fontface = "bold.italic", size = 4, color = "red") +
  xlab("") +
  ylab(paste0(gNAME,", mRNA Expression (RNA Seq V2 RSEM) (log2)")) +
  ggtitle("") +
  guides(fill = F) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.5, size = 12, face = "bold"), axis.title.y = element_text(size = 16, face = "bold"))
invisible(dev.off())
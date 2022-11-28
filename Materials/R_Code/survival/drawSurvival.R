library(survival)

setwd("/Users/dwhong/Desktop/R_code/survival")

expression <- read.csv("expression_groups.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",")
names(expression) <- c("sample_ID", "expression")

clinical_data <- read.csv("OS_DATA.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",")
names(clinical_data) <- c("sample_ID", "OS_STATUS", "OS_MONTHS")

clinical_data <- merge(clinical_data, expression, by = "sample_ID")

surv_test <- survfit(Surv(OS_MONTHS, OS_STATUS) ~ expression, data = clinical_data, conf.int = T)
survdiff_result <- survdiff(Surv(OS_MONTHS, OS_STATUS) ~ expression, data = clinical_data)
os_p_value <- 1 - pchisq(survdiff_result$chisq, df = (sum(1 * (survdiff_result$exp > 0))) - 1)

pdf(paste0("OS_survival.pdf"))
plot(surv_test, lty = 1, lwd = 1.3, col = c("red", "blue"), xlab = "Months", ylab = "Overall Survival" , cex = 1.3, cex.lab=1.2, xaxt="n")
axis(1, at = seq(0, 1200, 20))
invisible(dev.off())
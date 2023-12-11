library(tidyr)
library(treemapify)
library(dplyr)
library(ggplot2)

clarivateDataset <- NULL

clarivateDataPath <- "./raw_data/clarivate"
csvFiles <- list.files(path=clarivateDataPath, pattern = "*.csv")
for(csvFile in csvFiles){
  partial <- read.csv(paste(clarivateDataPath,csvFile,sep="/"), skip = 2, row.names = NULL);
  if(is.null(clarivateDataset)){
    clarivateDataset <- partial; # first csv file
  } else {
    clarivateDataset <- rbind(clarivateDataset, partial) #append partial to file
  }
}

colnames(clarivateDataset) <- c("Journal_name","JCR_Abbreviation","ISSN","eISSN","Category","Total_Citations","2022_JIF","JIF_Quartile","2022_JCI","percent_OA_gold")
clarivateDataset <- clarivateDataset[, 1:10] #get first 10 cols

clarivateDataset <- clarivateDataset[-which(clarivateDataset$JCR_Abbreviation==""),] #remove the two lines at the bottom of each csv
clarivateDataset[clarivateDataset$eISSN=="N/A","eISSN"] <- NA #replace N/A strings with actual NAs
clarivateDataset[clarivateDataset$ISSN=="N/A","ISSN"] <- NA #replace N/A strings with actual NAs


categories <- clarivateDataset %>%
  group_by(Category) %>%
  summarize(tot=n())

ggplot(categories, aes(area=tot, fill=Category, label = paste0(Category,"\n","(",tot,")"))) +
  geom_treemap() +
  geom_treemap_text(colour="white", place="topleft", reflow=T) +
  theme(legend.position="none")




clarivateDataset <- pivot_wider(clarivateDataset,
            names_from = Category,
            values_from = JIF_Quartile
)

clarivateDataset$Journal_name <- toupper(clarivateDataset$Journal_name) #make uppercase

saveRDS(clarivateDataset, "./data/clarivate.RDS")
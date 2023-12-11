library(openxlsx)

gevDataset <- read.xlsx("./raw_data/GEV/Elenco INF01 - Informatica.xlsx");

colnames(gevDataset) <- c("ISSN_1", "ISSN_2", "title");
gevDataset <- gevDataset[-which(gevDataset$title=="Titolo"),]

gevDataset$title <- toupper(gevDataset$title) #make uppercase


saveRDS(gevDataset, "./data/gev.RDS")
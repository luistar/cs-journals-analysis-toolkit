library(stringr)
library(tidyr)

scimagoDataset <- read.csv("./raw_data/scimagojr_2022.csv", sep = ";")
# scimagoDataset <- scimagoDataset[which(str_detect(scimagoDataset$Areas,"Computer Science")),]

# scimagoDataset <- read.csv("./raw_data/scimagojr 2022 Subject Area - Computer Science.csv", sep = ";")

#expand issn col
scimagoDataset <- separate_wider_delim(scimagoDataset, cols = Issn, delim = ", ", names = c("ISSN_1", "ISSN_2", "ISSN_3", "ISSN_4"), too_few = "align_start")

#normalize issns with a dash in the middle of them
scimagoDataset$ISSN_1 <- gsub('^([0-9A-Z]{4})([0-9A-Z]+)$', '\\1-\\2', scimagoDataset$ISSN_1)
scimagoDataset$ISSN_2 <- gsub('^([0-9A-Z]{4})([0-9A-Z]+)$', '\\1-\\2', scimagoDataset$ISSN_2)
scimagoDataset$ISSN_3 <- gsub('^([0-9A-Z]{4})([0-9A-Z]+)$', '\\1-\\2', scimagoDataset$ISSN_3)
scimagoDataset$ISSN_4 <- gsub('^([0-9A-Z]{4})([0-9A-Z]+)$', '\\1-\\2', scimagoDataset$ISSN_4)

scimagoDataset$Title <- toupper(scimagoDataset$Title)

scimagoCS <- scimagoDataset[which(str_detect(scimagoDataset$Areas,"Computer Science")),]

saveRDS(scimagoDataset, "./data/scimago.RDS");
saveRDS(scimagoCS, "./data/scimago_CS.RDS")


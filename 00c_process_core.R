library(stringr)
library(tidyr)

coreDataset <- read.csv("./raw_data/CORE_journals_2022.csv")

coreDataset$title <- toupper(coreDataset$title)

saveRDS(coreDataset, "./data/core.RDS")
library(dplyr)
library(jsonlite)
library(tidyr)
library(openxlsx)

outer_join_all <- readRDS("./data_joined/all_outer_join.RDS");

#move title column to first position
dataset <- outer_join_all %>%
  select(title, everything())


dataset$sources <- list(list())


for(row in 1:nrow(dataset)){
  current_sources <- list();
  if(! is.na(dataset[row,"scimago_title"]))
    current_sources <- append(current_sources, "scimago_cs");
  if(! is.na(dataset[row,"clarivate_title"]))
    current_sources <- append(current_sources, "clarivate");
  if(! is.na(dataset[row,"gev_title"]))
    current_sources <- append(current_sources, "gev");
  if(! is.na(dataset[row,"core_title"]))
    current_sources <- append(current_sources, "core");
  if(! is.na(dataset[row,"dblp_title"]))
    current_sources <- append(current_sources, "dblp");
  if(! is.na(dataset[row,"scimago_all_title"]) & is.na(dataset[row,"scimago_title"]))
    current_sources <- append(current_sources, "scimago_not_cs");
  dataset[row, "sources"][[1]] <- list(current_sources);
}

dataset <- dataset %>% unnest(sources)

dataset <- dataset %>%
  group_by(across(c(-sources))) %>%
  summarize(srcs = list(sources))

json <- toJSON(dataset)
write(json, file="./data_joined/dataset.json")
write.xlsx(dataset, "./data_joined/dataset.xlsx");
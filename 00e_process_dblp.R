library(tidyr)
library(stringr)

# Run ./raw_data/scrape_dblp_journals.R to download the journal list from DBLP and create the file read below
dblp <- read.csv("./raw_data/dblp_journals.csv")

# remove entry https://dblp.org/db/journals/jsjkx/: It's a journal with a chinese title ("Jisuanji kexue")?

# Split the ISSNs into separate columns.
# The collected journals have at most 6 different ISSNs (e.g.: see https://dblp.org/db/journals/jasis/index.html). Some of these are old.
dblp <- separate_wider_delim(dblp, cols = issns, delim = ",", names = c("ISSN_1", "ISSN_2", "ISSN_3", "ISSN_4", "ISSN_5", "ISSN_6"), too_few = "align_start", too_many = "merge")

# Due to the structure of the DBLP website, some junk was collected along with ISSNs (e.g.: links to prior names of the journal)
# In the following, we remove data that is not an ISSN

issn_regex <- regex("[0-9]{4}-[0-9]{3}([0-9]|x|X)")

dblp <- dblp %>%
  mutate(ISSN_1 = if_else(str_detect(ISSN_1, issn_regex), ISSN_1, NA_character_)) %>%
  mutate(ISSN_2 = if_else(str_detect(ISSN_2, issn_regex), ISSN_2, NA_character_)) %>%
  mutate(ISSN_3 = if_else(str_detect(ISSN_3, issn_regex), ISSN_3, NA_character_)) %>%
  mutate(ISSN_4 = if_else(str_detect(ISSN_4, issn_regex), ISSN_4, NA_character_)) %>%
  mutate(ISSN_5 = if_else(str_detect(ISSN_5, issn_regex), ISSN_5, NA_character_)) %>%
  mutate(ISSN_6 = if_else(str_detect(ISSN_6, issn_regex), ISSN_6, NA_character_))

dblp$title <- toupper(dblp$title)

saveRDS(dblp, "./data/dblp.RDS")
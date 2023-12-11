library(sqldf)
library(dplyr)

# read all data
scimago    <- readRDS("./data/scimago_CS.RDS")
clarivate  <- readRDS("./data/clarivate.RDS")
core       <- readRDS("./data/core.RDS")
gev        <- readRDS("./data/gev.RDS")
dblp       <- readRDS("./data/dblp.RDS")
scimagoAll <- readRDS("./data/scimago.RDS")

# outer_join_all <- sqldf("
# SELECT S.Title as scimago_title, W.Journal_name as clarivate_title, G.title as gev_title, C.title as core_title, S.Region as region, S.Country as country, S.Publisher as publisher, S.ISSN_1 as ISSN_1S, S.ISSN_2 as ISSN_2S, S.ISSN_3 as ISSN_3S, S.ISSN_4 as ISSN_4S, W.ISSN as ISSN_W, W.eISSN as ISSN_WE, G.ISSN_1 as ISSN_1G, G.ISSN_2 as ISSN_2G, C.ISSN1 as ISSN_1C, C.ISSN2 as ISSN_2C, C.ISSN3 as ISSN_3C, C.ISSN4 as ISSN_4C
# FROM scimago S
#   FULL OUTER JOIN clarivate W ON
#     S.ISSN_1 = W.ISSN OR S.ISSN_1 = W.eISSN OR
#     S.ISSN_2 = W.ISSN OR S.ISSN_2 = W.eISSN OR
#     S.ISSN_3 = W.ISSN OR S.ISSN_3 = W.eISSN OR
#     S.ISSN_4 = W.ISSN OR S.ISSN_4 = W.eISSN
#   FULL OUTER JOIN gev G ON
#     S.ISSN_1 = G.ISSN_1 OR S.ISSN_1 = G.ISSN_2 OR
#     S.ISSN_2 = G.ISSN_1 OR S.ISSN_2 = G.ISSN_2 OR
#     S.ISSN_3 = G.ISSN_1 OR S.ISSN_3 = G.ISSN_2 OR
#     S.ISSN_4 = G.ISSN_1 OR S.ISSN_4 = G.ISSN_2 OR
#     W.ISSN = G.ISSN_1 OR W.ISSN = G.ISSN_2 OR
#     W.eISSN = G.ISSN_1 OR W.eISSN = G.ISSN_2
#   FULL OUTER JOIN core C ON
#     S.ISSN_1 = C.ISSN1 OR S.ISSN_1 = C.ISSN2 OR S.ISSN_1 = C.ISSN3 OR S.ISSN_1 = C.ISSN4 OR
#     S.ISSN_2 = C.ISSN1 OR S.ISSN_2 = C.ISSN2 OR S.ISSN_2 = C.ISSN3 OR S.ISSN_2 = C.ISSN4 OR
#     S.ISSN_3 = C.ISSN1 OR S.ISSN_3 = C.ISSN2 OR S.ISSN_3 = C.ISSN3 OR S.ISSN_3 = C.ISSN4 OR
#     S.ISSN_4 = C.ISSN1 OR S.ISSN_4 = C.ISSN2 OR S.ISSN_4 = C.ISSN3 OR S.ISSN_4 = C.ISSN4 OR
#     W.ISSN = C.ISSN1 OR W.ISSN = C.ISSN2 OR W.ISSN = C.ISSN3 OR W.ISSN = C.ISSN4 OR
#     W.eISSN = C.ISSN1 OR W.eISSN = C.ISSN2 OR W.eISSN = C.ISSN3 OR W.eISSN = C.ISSN4 OR
#     G.ISSN_1 = C.ISSN1 OR G.ISSN_1 = C.ISSN2 OR G.ISSN_1 = C.ISSN3 OR G.ISSN_1 = C.ISSN4 OR
#     G.ISSN_2 = C.ISSN1 OR G.ISSN_2 = C.ISSN2 OR G.ISSN_2 = C.ISSN3 OR G.ISSN_2 = C.ISSN4
# ")


# all but dblp

# outer_join_all <- sqldf("
# SELECT S.Title as scimago_title, W.Journal_name as clarivate_title, G.title as gev_title, C.title as core_title, SA.Title as scimago_all_title, SA.Region as region, SA.Country as country, SA.Publisher as publisher, SA.Areas as scimago_areas, S.ISSN_1 as ISSN_1S, S.ISSN_2 as ISSN_2S, S.ISSN_3 as ISSN_3S, S.ISSN_4 as ISSN_4S, W.ISSN as ISSN_W, W.eISSN as ISSN_WE, G.ISSN_1 as ISSN_1G, G.ISSN_2 as ISSN_2G, C.ISSN1 as ISSN_1C, C.ISSN2 as ISSN_2C, C.ISSN3 as ISSN_3C, C.ISSN4 as ISSN_4C
# FROM scimago S
#   FULL OUTER JOIN clarivate W ON
#     S.ISSN_1 = W.ISSN OR S.ISSN_1 = W.eISSN OR
#     S.ISSN_2 = W.ISSN OR S.ISSN_2 = W.eISSN OR
#     S.ISSN_3 = W.ISSN OR S.ISSN_3 = W.eISSN OR
#     S.ISSN_4 = W.ISSN OR S.ISSN_4 = W.eISSN
#   FULL OUTER JOIN gev G ON
#     S.ISSN_1 = G.ISSN_1 OR S.ISSN_1 = G.ISSN_2 OR
#     S.ISSN_2 = G.ISSN_1 OR S.ISSN_2 = G.ISSN_2 OR
#     S.ISSN_3 = G.ISSN_1 OR S.ISSN_3 = G.ISSN_2 OR
#     S.ISSN_4 = G.ISSN_1 OR S.ISSN_4 = G.ISSN_2 OR
#     W.ISSN = G.ISSN_1 OR W.ISSN = G.ISSN_2 OR
#     W.eISSN = G.ISSN_1 OR W.eISSN = G.ISSN_2
#   FULL OUTER JOIN core C ON
#     S.ISSN_1 = C.ISSN1 OR S.ISSN_1 = C.ISSN2 OR S.ISSN_1 = C.ISSN3 OR S.ISSN_1 = C.ISSN4 OR
#     S.ISSN_2 = C.ISSN1 OR S.ISSN_2 = C.ISSN2 OR S.ISSN_2 = C.ISSN3 OR S.ISSN_2 = C.ISSN4 OR
#     S.ISSN_3 = C.ISSN1 OR S.ISSN_3 = C.ISSN2 OR S.ISSN_3 = C.ISSN3 OR S.ISSN_3 = C.ISSN4 OR
#     S.ISSN_4 = C.ISSN1 OR S.ISSN_4 = C.ISSN2 OR S.ISSN_4 = C.ISSN3 OR S.ISSN_4 = C.ISSN4 OR
#     W.ISSN = C.ISSN1 OR W.ISSN = C.ISSN2 OR W.ISSN = C.ISSN3 OR W.ISSN = C.ISSN4 OR
#     W.eISSN = C.ISSN1 OR W.eISSN = C.ISSN2 OR W.eISSN = C.ISSN3 OR W.eISSN = C.ISSN4 OR
#     G.ISSN_1 = C.ISSN1 OR G.ISSN_1 = C.ISSN2 OR G.ISSN_1 = C.ISSN3 OR G.ISSN_1 = C.ISSN4 OR
#     G.ISSN_2 = C.ISSN1 OR G.ISSN_2 = C.ISSN2 OR G.ISSN_2 = C.ISSN3 OR G.ISSN_2 = C.ISSN4
#   LEFT OUTER JOIN scimagoAll SA ON
#     SA.ISSN_1 = C.ISSN1 OR SA.ISSN_1 = C.ISSN2 OR SA.ISSN_1 = C.ISSN3 OR SA.ISSN_1 = C.ISSN4 OR
#     SA.ISSN_2 = C.ISSN1 OR SA.ISSN_2 = C.ISSN2 OR SA.ISSN_2 = C.ISSN3 OR SA.ISSN_2 = C.ISSN4 OR
#     SA.ISSN_3 = C.ISSN1 OR SA.ISSN_3 = C.ISSN2 OR SA.ISSN_3 = C.ISSN3 OR SA.ISSN_3 = C.ISSN4 OR
#     SA.ISSN_4 = C.ISSN1 OR SA.ISSN_4 = C.ISSN2 OR SA.ISSN_4 = C.ISSN3 OR SA.ISSN_4 = C.ISSN4 OR
#     W.ISSN = SA.ISSN_1 OR W.ISSN = SA.ISSN_2 OR W.ISSN = SA.ISSN_3 OR W.ISSN = SA.ISSN_4 OR
#     W.eISSN = SA.ISSN_1 OR W.eISSN = SA.ISSN_2 OR W.eISSN = SA.ISSN_3 OR W.eISSN = SA.ISSN_4 OR
#     G.ISSN_1 = SA.ISSN_1 OR G.ISSN_1 = SA.ISSN_2 OR G.ISSN_1 = SA.ISSN_3 OR G.ISSN_1 = SA.ISSN_4 OR
#     G.ISSN_2 = SA.ISSN_1 OR G.ISSN_2 = SA.ISSN_2 OR G.ISSN_2 = SA.ISSN_3 OR G.ISSN_2 = SA.ISSN_4
# ")


outer_join_all <- sqldf("
SELECT S.Title as scimago_title, W.Journal_name as clarivate_title, G.title as gev_title, C.title as core_title, D.title as dblp_title, SA.Title as scimago_all_title, SA.Region as region, SA.Country as country, SA.Publisher as publisher, SA.Areas as scimago_areas, S.ISSN_1 as ISSN_1S, S.ISSN_2 as ISSN_2S, S.ISSN_3 as ISSN_3S, S.ISSN_4 as ISSN_4S, W.ISSN as ISSN_W, W.eISSN as ISSN_WE, G.ISSN_1 as ISSN_1G, G.ISSN_2 as ISSN_2G, C.ISSN1 as ISSN_1C, C.ISSN2 as ISSN_2C, C.ISSN3 as ISSN_3C, C.ISSN4 as ISSN_4C, D.ISSN_1 as ISSN_1D, D.ISSN_2 as ISSN_2D, D.ISSN_3 as ISSN_3D, D.ISSN_4 as ISSN_4D, D.ISSN_5 as ISSN_5D, D.ISSN_6 as ISSN_6D
FROM scimago S
  FULL OUTER JOIN clarivate W ON
    S.ISSN_1 = W.ISSN OR S.ISSN_1 = W.eISSN OR
    S.ISSN_2 = W.ISSN OR S.ISSN_2 = W.eISSN OR
    S.ISSN_3 = W.ISSN OR S.ISSN_3 = W.eISSN OR
    S.ISSN_4 = W.ISSN OR S.ISSN_4 = W.eISSN
  FULL OUTER JOIN gev G ON
    S.ISSN_1 = G.ISSN_1 OR S.ISSN_1 = G.ISSN_2 OR
    S.ISSN_2 = G.ISSN_1 OR S.ISSN_2 = G.ISSN_2 OR
    S.ISSN_3 = G.ISSN_1 OR S.ISSN_3 = G.ISSN_2 OR
    S.ISSN_4 = G.ISSN_1 OR S.ISSN_4 = G.ISSN_2 OR
    W.ISSN = G.ISSN_1 OR W.ISSN = G.ISSN_2 OR
    W.eISSN = G.ISSN_1 OR W.eISSN = G.ISSN_2
  FULL OUTER JOIN core C ON
    S.ISSN_1 = C.ISSN1 OR S.ISSN_1 = C.ISSN2 OR S.ISSN_1 = C.ISSN3 OR S.ISSN_1 = C.ISSN4 OR
    S.ISSN_2 = C.ISSN1 OR S.ISSN_2 = C.ISSN2 OR S.ISSN_2 = C.ISSN3 OR S.ISSN_2 = C.ISSN4 OR
    S.ISSN_3 = C.ISSN1 OR S.ISSN_3 = C.ISSN2 OR S.ISSN_3 = C.ISSN3 OR S.ISSN_3 = C.ISSN4 OR
    S.ISSN_4 = C.ISSN1 OR S.ISSN_4 = C.ISSN2 OR S.ISSN_4 = C.ISSN3 OR S.ISSN_4 = C.ISSN4 OR
    W.ISSN = C.ISSN1 OR W.ISSN = C.ISSN2 OR W.ISSN = C.ISSN3 OR W.ISSN = C.ISSN4 OR
    W.eISSN = C.ISSN1 OR W.eISSN = C.ISSN2 OR W.eISSN = C.ISSN3 OR W.eISSN = C.ISSN4 OR
    G.ISSN_1 = C.ISSN1 OR G.ISSN_1 = C.ISSN2 OR G.ISSN_1 = C.ISSN3 OR G.ISSN_1 = C.ISSN4 OR
    G.ISSN_2 = C.ISSN1 OR G.ISSN_2 = C.ISSN2 OR G.ISSN_2 = C.ISSN3 OR G.ISSN_2 = C.ISSN4
  FULL OUTER JOIN dblp D ON
    S.ISSN_1 = D.ISSN_1 OR S.ISSN_1 = D.ISSN_2 OR S.ISSN_1 = D.ISSN_3 OR S.ISSN_1 = D.ISSN_4 OR S.ISSN_1 = D.ISSN_5 OR S.ISSN_1 = D.ISSN_6 OR
    S.ISSN_2 = D.ISSN_1 OR S.ISSN_2 = D.ISSN_2 OR S.ISSN_2 = D.ISSN_3 OR S.ISSN_2 = D.ISSN_4 OR S.ISSN_2 = D.ISSN_5 OR S.ISSN_2 = D.ISSN_6 OR
    S.ISSN_3 = D.ISSN_1 OR S.ISSN_3 = D.ISSN_2 OR S.ISSN_3 = D.ISSN_3 OR S.ISSN_3 = D.ISSN_4 OR S.ISSN_3 = D.ISSN_5 OR S.ISSN_3 = D.ISSN_6 OR
    S.ISSN_4 = D.ISSN_1 OR S.ISSN_4 = D.ISSN_2 OR S.ISSN_4 = D.ISSN_3 OR S.ISSN_4 = D.ISSN_4 OR S.ISSN_4 = D.ISSN_5 OR S.ISSN_4 = D.ISSN_6 OR
    W.ISSN = D.ISSN_1 OR W.ISSN = D.ISSN_2 OR W.ISSN = D.ISSN_3 OR W.ISSN = D.ISSN_4 OR W.ISSN = D.ISSN_5 OR W.ISSN = D.ISSN_6 OR
    W.eISSN = D.ISSN_1 OR W.eISSN = D.ISSN_2 OR W.eISSN = D.ISSN_3 OR W.eISSN = D.ISSN_4 OR W.eISSN = D.ISSN_5 OR W.eISSN = D.ISSN_6 OR
    G.ISSN_1 = D.ISSN_1 OR G.ISSN_1 = D.ISSN_2 OR G.ISSN_1 = D.ISSN_3 OR G.ISSN_1 = D.ISSN_4 OR G.ISSN_1 = D.ISSN_5 OR G.ISSN_1 = D.ISSN_6 OR
    G.ISSN_2 = D.ISSN_1 OR G.ISSN_2 = D.ISSN_2 OR G.ISSN_2 = D.ISSN_3 OR G.ISSN_2 = D.ISSN_4 OR G.ISSN_2 = D.ISSN_5 OR G.ISSN_2 = D.ISSN_6 OR
    C.ISSN1 = D.ISSN_1 OR C.ISSN1 = D.ISSN_2 OR C.ISSN1 = D.ISSN_3 OR C.ISSN1 = D.ISSN_4 OR C.ISSN1 = D.ISSN_5 OR C.ISSN1 = D.ISSN_6 OR
    C.ISSN2 = D.ISSN_1 OR C.ISSN2 = D.ISSN_2 OR C.ISSN2 = D.ISSN_3 OR C.ISSN2 = D.ISSN_4 OR C.ISSN2 = D.ISSN_5 OR C.ISSN2 = D.ISSN_6 OR
    C.ISSN3 = D.ISSN_1 OR C.ISSN3 = D.ISSN_2 OR C.ISSN3 = D.ISSN_3 OR C.ISSN3 = D.ISSN_4 OR C.ISSN3 = D.ISSN_5 OR C.ISSN3 = D.ISSN_6 OR
    C.ISSN4 = D.ISSN_1 OR C.ISSN4 = D.ISSN_2 OR C.ISSN4 = D.ISSN_3 OR C.ISSN4 = D.ISSN_4 OR C.ISSN4 = D.ISSN_5 OR C.ISSN4 = D.ISSN_6
  LEFT OUTER JOIN scimagoAll SA ON
    SA.ISSN_1 = C.ISSN1 OR SA.ISSN_1 = C.ISSN2 OR SA.ISSN_1 = C.ISSN3 OR SA.ISSN_1 = C.ISSN4 OR
    SA.ISSN_2 = C.ISSN1 OR SA.ISSN_2 = C.ISSN2 OR SA.ISSN_2 = C.ISSN3 OR SA.ISSN_2 = C.ISSN4 OR
    SA.ISSN_3 = C.ISSN1 OR SA.ISSN_3 = C.ISSN2 OR SA.ISSN_3 = C.ISSN3 OR SA.ISSN_3 = C.ISSN4 OR
    SA.ISSN_4 = C.ISSN1 OR SA.ISSN_4 = C.ISSN2 OR SA.ISSN_4 = C.ISSN3 OR SA.ISSN_4 = C.ISSN4 OR
    W.ISSN = SA.ISSN_1 OR W.ISSN = SA.ISSN_2 OR W.ISSN = SA.ISSN_3 OR W.ISSN = SA.ISSN_4 OR
    W.eISSN = SA.ISSN_1 OR W.eISSN = SA.ISSN_2 OR W.eISSN = SA.ISSN_3 OR W.eISSN = SA.ISSN_4 OR
    G.ISSN_1 = SA.ISSN_1 OR G.ISSN_1 = SA.ISSN_2 OR G.ISSN_1 = SA.ISSN_3 OR G.ISSN_1 = SA.ISSN_4 OR
    G.ISSN_2 = SA.ISSN_1 OR G.ISSN_2 = SA.ISSN_2 OR G.ISSN_2 = SA.ISSN_3 OR G.ISSN_2 = SA.ISSN_4 OR
    SA.ISSN_1 = D.ISSN_1 OR SA.ISSN_1 = D.ISSN_2 OR SA.ISSN_1 = D.ISSN_3 OR SA.ISSN_1 = D.ISSN_4 OR SA.ISSN_1 = D.ISSN_5 OR SA.ISSN_1 = D.ISSN_6 OR
    SA.ISSN_2 = D.ISSN_1 OR SA.ISSN_2 = D.ISSN_2 OR SA.ISSN_2 = D.ISSN_3 OR SA.ISSN_2 = D.ISSN_4 OR SA.ISSN_2 = D.ISSN_5 OR SA.ISSN_2 = D.ISSN_6 OR
    SA.ISSN_3 = D.ISSN_1 OR SA.ISSN_3 = D.ISSN_2 OR SA.ISSN_3 = D.ISSN_3 OR SA.ISSN_3 = D.ISSN_4 OR SA.ISSN_3 = D.ISSN_5 OR SA.ISSN_3 = D.ISSN_6 OR
    SA.ISSN_4 = D.ISSN_1 OR SA.ISSN_4 = D.ISSN_2 OR SA.ISSN_4 = D.ISSN_3 OR SA.ISSN_4 = D.ISSN_4 OR SA.ISSN_4 = D.ISSN_5 OR SA.ISSN_4 = D.ISSN_6
")


#select the first non-na title as the "global" title
outer_join_all <- outer_join_all %>% mutate(title = coalesce(scimago_title,clarivate_title,gev_title, core_title, dblp_title))

#merge the 17 journals with the same title and different issns and coalesce on issns
outer_join_all <- outer_join_all %>%
  group_by(title) %>%
  fill(everything(), .direction = "down") %>%
  fill(everything(), .direction = "up") %>%
  slice(1)

saveRDS(outer_join_all, "./data_joined/all_outer_join.RDS")

scimago_joined <- sqldf("
  SELECT title, region, country, publisher, scimago_areas, ISSN_1S, ISSN_2S, ISSN_3S, ISSN_4S, ISSN_W, ISSN_WE, ISSN_1G, ISSN_2G, ISSN_1C, ISSN_2C, ISSN_3C, ISSN_4C, ISSN_1D, ISSN_2D, ISSN_3D, ISSN_4D, ISSN_5D, ISSN_6D
  FROM outer_join_all
  WHERE scimago_title IS NOT NULL
")

clarivate_joined <- sqldf("
  SELECT title, region, country, publisher, scimago_areas, ISSN_1S, ISSN_2S, ISSN_3S, ISSN_4S, ISSN_W, ISSN_WE, ISSN_1G, ISSN_2G, ISSN_1C, ISSN_2C, ISSN_3C, ISSN_4C, ISSN_1D, ISSN_2D, ISSN_3D, ISSN_4D, ISSN_5D, ISSN_6D
  FROM outer_join_all
  WHERE clarivate_title IS NOT NULL
")

gev_joined <- sqldf("
  SELECT title, region, country, publisher, scimago_areas, ISSN_1S, ISSN_2S, ISSN_3S, ISSN_4S, ISSN_W, ISSN_WE, ISSN_1G, ISSN_2G, ISSN_1C, ISSN_2C, ISSN_3C, ISSN_4C, ISSN_1D, ISSN_2D, ISSN_3D, ISSN_4D, ISSN_5D, ISSN_6D
  FROM outer_join_all
  WHERE gev_title IS NOT NULL
")

core_joined <- sqldf("
  SELECT title, core_title, region, country, publisher, scimago_areas, ISSN_1S, ISSN_2S, ISSN_3S, ISSN_4S, ISSN_W, ISSN_WE, ISSN_1G, ISSN_2G, ISSN_1C, ISSN_2C, ISSN_3C, ISSN_4C, ISSN_1D, ISSN_2D, ISSN_3D, ISSN_4D, ISSN_5D, ISSN_6D
  FROM outer_join_all
  WHERE core_title IS NOT NULL
")

dblp_joined <- sqldf("
  SELECT title, dblp_title, region, country, publisher, scimago_areas, ISSN_1S, ISSN_2S, ISSN_3S, ISSN_4S, ISSN_W, ISSN_WE, ISSN_1G, ISSN_2G, ISSN_1C, ISSN_2C, ISSN_3C, ISSN_4C, ISSN_1D, ISSN_2D, ISSN_3D, ISSN_4D, ISSN_5D, ISSN_6D
  FROM outer_join_all
  WHERE dblp_title IS NOT NULL
")

scimago_all_joined <- sqldf("
  SELECT title, region, country, publisher, scimago_areas, ISSN_1S, ISSN_2S, ISSN_3S, ISSN_4S, ISSN_W, ISSN_WE, ISSN_1G, ISSN_2G, ISSN_1C, ISSN_2C, ISSN_3C, ISSN_4C, ISSN_1D, ISSN_2D, ISSN_3D, ISSN_4D, ISSN_5D, ISSN_6D
  FROM outer_join_all
  WHERE scimago_all_title IS NOT NULL
")

saveRDS(scimago_joined, "./data_joined/scimago.RDS")
saveRDS(clarivate_joined, "./data_joined/clarivate.RDS")
saveRDS(gev_joined, "./data_joined/gev.RDS")
saveRDS(core_joined, "./data_joined/core.RDS")
saveRDS(dblp_joined, "./data_joined/dblp.RDS")
saveRDS(scimago_all_joined, "./data_joined/scimago_all.RDS")


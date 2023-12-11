library(ggplot2)
library(ggVennDiagram)
library(ggupset)
library(tidyr)
library(dplyr)
library(eulerr)

scimago <- readRDS("./data_joined/scimago.RDS")
scimago_all <- readRDS("./data_joined/scimago_all.RDS")
clarivate <- readRDS("./data_joined/clarivate.RDS")
core <- readRDS("./data_joined/core.RDS")
gev <- readRDS("./data_joined/gev.RDS")
dblp <- readRDS("./data_joined/dblp.RDS")

scimago_not_cs <- scimago_all[which(!str_detect(scimago_all$scimago_areas,"Computer Science")),]


data <- list(scopus_cs = scimago$title,
             clarivate = clarivate$title,
             core = core$title,
             gev = gev$title,
             dblp = dblp$title
)

ggVennDiagram(data, set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

ggsave("./visualizations/venn.png", width=20, height=10)

ggVennDiagram(list(scopus_cs = scimago$title, scopus_not_cs=scimago_not_cs$title,
             clarivate = clarivate$title,
             core = core$title,
             gev = gev$title,
             dblp = dblp$title
), set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

ggsave("./visualizations/venn_all.png", width=20, height=10)

data <- list(
  source = c(
    rep("scopus_cs",nrow(scimago)),
    rep("scopus_not_cs",nrow(scimago_not_cs)),
    rep("clarivate", nrow(clarivate)),
    rep("core", nrow(core)),
    rep("gev", nrow(gev)),
    rep("dblp", nrow(dblp))
  ),
  title = c(
    scimago$title,
    scimago_not_cs$title,
    clarivate$title,
    core$title,
    gev$title,
    dblp$title
  )
)

df <- as.data.frame(data) %>%
  group_by(title) %>%
  summarize(sources = list(source))

upset <- ggplot(df, aes(x=sources)) +
    geom_bar(fill="#00647a") + geom_text(stat='count', aes(label=after_stat(count)), vjust=-0.5, color="#00323d") +
    scale_x_upset() +
    theme_combmatrix(combmatrix.label.text = element_text(size=14),
                     combmatrix.label.extra_spacing = 5) +
    theme(
      axis.text = element_text(size=12),
      axis.title = element_text(size=14)
    )
upset

ggsave("./visualizations/upset_plot.png", upset, width=15, height=6)
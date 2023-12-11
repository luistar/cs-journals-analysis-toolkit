library(ggplot2)
library(ggVennDiagram)
library(ggupset)
library(tidyr)
library(dplyr)
library(eulerr)
library(stringr)

scimago <- readRDS("./data_joined/scimago.RDS")
scimago_all <- readRDS("./data_joined/scimago_all.RDS")
clarivate <- readRDS("./data_joined/clarivate.RDS")
core <- readRDS("./data_joined/core.RDS")
gev <- readRDS("./data_joined/gev.RDS")
dblp <- readRDS("./data_joined/dblp.RDS")

scimago_not_cs <- scimago_all[which(!str_detect(scimago_all$scimago_areas,"Computer Science")),]

# SCOPUS VS WOS

ggVennDiagram(list(
  scimago_cs = scimago$title,
  clarivate  = clarivate$title,
  scimago_not_cs = scimago_not_cs$title
),
set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

euler_diagram <- euler(
  c(
    "Scopus CS" = 1025, "Scopus not CS"=254, "WoS" = 80,
    "Scopus CS&WoS" = 809, "Scopus CS&Scopus not CS"=0, "Scopus not CS&WoS" = 399,
    "Scopus CS&Scopus not CS&WoS" = 0
  ),
  shape="ellipse"
)
plot(euler_diagram,
  quantities = list(type = c("counts", "percent"), font=10, round=2, cex=1.25, fontsize=16),
     fills =list(fill=c(viridis::viridis(n = 4))), alpha = 0.5, c("black"), alpha = 0.1, edges=list(lty = 1), factor_names = TRUE, labels=list(font=4, fontsize=16, cex=1.25), legend = FALSE
)


# SCOPUS VS GEV

ggVennDiagram(list(
  scimago_cs = scimago$title,
  gev  = gev$title,
  scimago_not_cs = scimago_not_cs$title
),
set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

euler_diagram <- euler(
  c(
    "Scopus CS" = 885, "Scopus not CS"=474, "GEV" = 15,
    "Scopus CS&GEV" = 949, "Scopus not CS&GEV" = 179,
    "Scopus CS&Scopus not CS&GEV" = 0, "Scopus CS&Scopus not CS"=0
  ),
  shape="ellipse"
)
plot(euler_diagram,
  quantities = list(type = c("counts", "percent"), font=10, round=2, cex=1.25, fontsize=16),
     fills =list(fill=c(viridis::viridis(n = 4))), alpha = 0.5, c("black"), alpha = 0.1, edges=list(lty = 1), factor_names = TRUE, labels=list(font=4, fontsize=16, cex=1.25), legend = FALSE
)

# SCOPUS VS CORE

ggVennDiagram(list(
  scimago_cs = scimago$title,
  core  = core$title,
  scimago_not_cs = scimago_not_cs$title
),
set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

euler_diagram <- euler(
  c(
    "Scopus CS" = 1395, "Scopus not CS"=584, "CORE" = 131,
    "Scopus CS&CORE" = 439, "Scopus not CS&CORE" = 69,
    "Scopus CS&Scopus not CS&GEV" = 0, "Scopus CS&Scopus not CS"=0
  ),
  shape="ellipse"
)
plot(euler_diagram,
  quantities = list(type = c("counts", "percent"), font=10, round=2, cex=1.25, fontsize=16),
     fills =list(fill=c(viridis::viridis(n = 4))), alpha = 0.5, c("black"), alpha = 0.1, edges=list(lty = 1), factor_names = TRUE, labels=list(font=4, fontsize=16, cex=1.25), legend = FALSE
)


# SCOPUS VS DBLP

ggVennDiagram(list(
  scimago_cs = scimago$title,
  dblp  = dblp$title,
  scimago_not_cs = scimago_not_cs$title
),
set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

euler_diagram <- euler(
  c(
    "Scopus CS" = 814, "Scopus not CS"=329, "DBLP" = 510,
    "Scopus CS&DBLP" = 1020, "Scopus not CS&DBLP" = 324,
    "Scopus CS&Scopus not CS&DBLP" = 0, "Scopus CS&Scopus not CS"=0
  ),
  shape="ellipse"
)
plot(euler_diagram,
  quantities = list(type = c("counts", "percent"), font=10, round=2, cex=1.25, fontsize=16),
     fills =list(fill=c(viridis::viridis(n = 4))), alpha = 0.5, c("black"), alpha = 0.1, edges=list(lty = 1), factor_names = TRUE, labels=list(font=4, fontsize=16, cex=1.25), legend = FALSE
)


# WoS VS GEV

ggVennDiagram(list(
  clarivate = clarivate$title,
  gev  = gev$title
),
set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

euler_diagram <- euler(
  c(
    "WoS" = 617, "GEV"=472,
    "WoS&GEV" = 671
  ),
  shape="ellipse"
)
plot(euler_diagram,
  quantities = list(type = c("counts", "percent"), font=10, round=2, cex=1.25, fontsize=16),
     fills =list(fill=c(viridis::viridis(n = 4))), alpha = 0.5, c("black"), alpha = 0.1, edges=list(lty = 1), factor_names = TRUE, labels=list(font=4, fontsize=16, cex=1.25), legend = FALSE
)


# WoS VS CORE

ggVennDiagram(list(
  clarivate = clarivate$title,
  core  = core$title
),
set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

euler_diagram <- euler(
  c(
    "WoS" = 910, "CORE"=261,
    "WoS&CORE" = 378
  ),
  shape="ellipse"
)
plot(euler_diagram,
  quantities = list(type = c("counts", "percent"), font=10, round=2, cex=1.25, fontsize=16),
     fills =list(fill=c(viridis::viridis(n = 4))), alpha = 0.5, c("black"), alpha = 0.1, edges=list(lty = 1), factor_names = TRUE, labels=list(font=4, fontsize=16, cex=1.25), legend = FALSE
)

# WoS VS DBLP

ggVennDiagram(list(
  clarivate = clarivate$title,
  dblp  = dblp$title
),
set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

euler_diagram <- euler(
  c(
    "WoS" = 502, "DBLP"=1068,
    "WoS&DBLP" = 786
  ),
  shape="ellipse"
)
plot(euler_diagram,
  quantities = list(type = c("counts", "percent"), font=10, round=2, cex=1.25, fontsize=16),
     fills =list(fill=c(viridis::viridis(n = 4))), alpha = 0.5, c("black"), alpha = 0.1, edges=list(lty = 1), factor_names = TRUE, labels=list(font=4, fontsize=16, cex=1.25), legend = FALSE
)


# GEV VS CORE

ggVennDiagram(list(
  gev = gev$title,
  core  = core$title
),
set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

euler_diagram <- euler(
  c(
    "GEV" = 673, "CORE"=169,
    "GEV&CORE" = 470
  ),
  shape="ellipse"
)
plot(euler_diagram,
  quantities = list(type = c("counts", "percent"), font=10, round=2, cex=1.25, fontsize=16),
     fills =list(fill=c(viridis::viridis(n = 4))), alpha = 0.5, c("black"), alpha = 0.1, edges=list(lty = 1), factor_names = TRUE, labels=list(font=4, fontsize=16, cex=1.25), legend = FALSE
)


# GEV VS DBLP

ggVennDiagram(list(
  gev = gev$title,
  dblp  = dblp$title
),
set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

euler_diagram <- euler(
  c(
    "GEV" = 142, "DBLP"=853,
    "GEV&DBLP" = 1001
  ),
  shape="ellipse"
)
plot(euler_diagram,
  quantities = list(type = c("counts", "percent"), font=10, round=2, cex=1.25, fontsize=16),
     fills =list(fill=c(viridis::viridis(n = 4))), alpha = 0.5, c("black"), alpha = 0.1, edges=list(lty = 1), factor_names = TRUE, labels=list(font=4, fontsize=16, cex=1.25), legend = FALSE
)

# CORE VS DBLP

ggVennDiagram(list(
  core = core$title,
  dblp  = dblp$title
),
set_size=8, label_size=6) + scale_fill_gradient(low="#00323d", high="#00647a")

euler_diagram <- euler(
  c(
    "CORE" = 120, "DBLP"=1335,
    "CORE&DBLP" = 519
  ),
  shape="ellipse"
)
plot(euler_diagram,
  quantities = list(type = c("counts", "percent"), font=10, round=2, cex=1.25, fontsize=16),
     fills =list(fill=c(viridis::viridis(n = 4))), alpha = 0.5, c("black"), alpha = 0.1, edges=list(lty = 1), factor_names = TRUE, labels=list(font=4, fontsize=16, cex=1.25), legend = FALSE
)

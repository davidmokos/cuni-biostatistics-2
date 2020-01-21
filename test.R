library(vegan)
library(readxl)
library(dplyr)

bistorta <- read_excel("bistorta/bistorta.xls")

class(bistorta)
head(bistorta)
dim(bistorta)

bistorta %>% select(c(Polybist, hnoj))

bistorta %>% mutate(kos = as.logical(kos))

bistorta %>% filter(hnoj == 1)

hist(bistorta$Descflex)

bistorta %>%
  select(Polybist) %>% 
  boxplot()

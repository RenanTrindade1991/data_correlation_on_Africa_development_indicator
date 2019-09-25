library(tidyr)
library(dplyr)
library(wbstats)
library(readxl)
library(ggplot2)
library(readr)
library(ggthemes)
library(stringr)
library(scales)
library(gridExtra)

WBDATA <- wb_cachelist
WBDATA <- data.frame(WBDATA$indicators)
WBDATA <- WBDATA %>% filter(sourceID == "11")
iso3c <- vector()
date <- vector()
value <- vector()
indicatorID <- vector()
indicator <- vector()
iso2c <- vector()
country <- vector()

b <- data_frame(iso3c, date, value, indicatorID, indicator, iso2c, country)

for (i in WBDATA$indicatorID) {
a <- wb(indicator = i)
b <-  rbind(a, b)
}
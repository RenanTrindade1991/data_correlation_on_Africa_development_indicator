library(tidyr)
library(dplyr)
library(wbstats)
library(readxl)
library(ggplot2)
library(readr)
library(ggthemes)
library(stringr)
library(scales)

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



c <- b[-1]
c <- c[-1]
c <- c[-1]
c <- c[-2]
c <- c[-3]
c <- c[-3]

d <- c %>% 
  group_by_at(vars(-value)) %>%  # group by everything other than the value column. 
  mutate(row_id=1:n()) %>% ungroup() %>%  # build group index
  spread(key=indicator, value=value) %>%    # spread
  select(-row_id)

rm(c, b)

tb <- "correlat"
tbn1 <- "primeiro"
tbn2 <- "segundo"
x <- 0
for (i in c(seq(1,length(d)))) {
  for (e in c(seq(1,length(d)))) {
    x <- x + 1
    tbn1[x] <- as.character(names(d[i]))
    tbn2[x] <- as.character(names(d[e]))
    temp <- d[c(i, e)]
    temp <- na.omit(temp)
    tb[x] <- cor(temp[1], temp[2])
  }
}

a <- data.frame(tbn1, tbn2, tb)

a$val <- as.character(a$tb)
a$val <- as.numeric(a$val)
a <- a[-3]

rm(tbn1, tbn2, i, e, x, temp, tb)



c <- a %>% filter(val >= 0.8 | val <= -0.8)
c <- c %>% filter(val != 1)

x <- vector()
z <- 0
for (i in c(seq(1,length(d)))) {
  
  x <- paste(c[i, 1], c[i, 2])
  
  for (o in c(seq(1,length(d)))) {
    z <- z+1
    if (x == paste(c[o, 2], c[o, 1])) {
      c <- c[-o,]
    } 
    
  }}

c$tbn1 <- as.character(c$tbn1)
c$tbn2 <- as.character(c$tbn2)


str_sub(c$tbn1, (str_count(c$tbn1)+1)) <- "`"
c$temp <- "`"
str_sub(c$temp, 2) <- c$tbn1
c$tbn1 <- c$temp

str_sub(c$tbn2, (str_count(c$tbn2)+1)) <- "`"
c$temp <- "`"
str_sub(c$temp, 2) <- c$tbn2
c$tbn2 <- c$temp

c <- c[-4]

axis_x_def <- character()
axis_y_def <- character()
for (i in c(seq(1,length(d)))) {
  axis_x_def <- c[i, 1]
  axis_y_def <- c[i, 2]
  ggplot(d, aes_string(x = axis_x_def, y = axis_y_def)) + geom_point()
}


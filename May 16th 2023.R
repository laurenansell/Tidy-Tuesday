#########################################################################################
#########################################################################################
###                                                                                   ###
###                     Tidy Tuesday: Tornado data 16/05/2023                         ###
###                                                                                   ###
#########################################################################################
#########################################################################################

### Programmed by Lauren Ansell
### Date: 16/05/2023

## required libraries
library(plyr)
library(dplyr)
library(ggplot2)


## Data
tornados <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-05-16/tornados.csv')

names(tornados)
str(tornados)

## The strength and number per year

## Create the two data frames
strength_by_year<-tornados %>% group_by(yr) %>% summarise(ave=mean(mag,na.rm = TRUE),
                                                          min=min(mag,na.rm=TRUE),
                                                          max=max(mag,na.rm = TRUE))


number_per_year<-tornados %>% group_by(yr) %>% count()

## Plotting the results
ggplot(strength_by_year,aes(x=yr,y=ave))+geom_line(linewidth=2)+
  labs(title="Average magnitude of tornados in the USA 1950-2022")+
  xlab("Year")+ylab("Average magnitude (F scale)")

ggplot(number_per_year,aes(x=yr,y=n))+geom_line(linewidth=2)+
  labs(title="Number of tornados in the USA 1950-2022")+
  xlab("Year")+ylab("Number of tornados")


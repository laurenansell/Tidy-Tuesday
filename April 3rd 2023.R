#########################################################################################
#########################################################################################
###                                                                                   ###
###                    Tidy Tuesday: Football data 03/04/2023                         ###
###                                                                                   ###
#########################################################################################
#########################################################################################

### Programmed by Lauren Ansell
### Date: 03/04/2023

## required libraries
library(plyr)
library(dplyr)
library(ggplot2)

## Data
football_data<-read.csv("soccer21-22.csv")

str(football_data)

### Who squanders the most chances?

### Need the team name and the total number goals scores, shots on target and shots

football_data_filtered<-football_data %>% select(HomeTeam,AwayTeam,
                                                 FTHG,FTAG,
                                                 HS,AS,
                                                 HST,AST)

## Seperate home and away teams

Home<-football_data_filtered %>% select(HomeTeam,
                                        FTHG,HS,
                                        HST)

Away<-football_data_filtered %>% select(AwayTeam,
                                        FTAG,AS,
                                        AST)
## rename the columns to bind

names(Home)[1]<-"Team"
names(Home)[2]<-"Goals"
names(Home)[3]<-"Shots"
names(Home)[4]<-"On_target"

names(Away)[1]<-"Team"
names(Away)[2]<-"Goals"
names(Away)[3]<-"Shots"
names(Away)[4]<-"On_target"

football_data<-rbind(Home,Away)

football_data<-football_data %>% group_by(Team) %>% summarise(Goals=sum(Goals),
                                                              Shots=sum(Shots),
                                                              Target=sum(On_target))

football_data<-football_data %>% mutate(goals_per_shot=Goals/Shots,
                                        on_target_ratio=Target/Shots)

football_data_1<-arrange(football_data,goals_per_shot)

ggplot(football_data_1,aes(x=reorder(Team,goals_per_shot),y=goals_per_shot))+geom_bar(stat="identity",col="blue",fill="blue")+coord_flip()+labs(x="Team",y="Goals per shots taken")


ggplot(football_data,aes(x=reorder(Team,on_target_ratio),y=on_target_ratio))+geom_bar(stat="identity",col="blue",fill="blue")+coord_flip()+labs(x="Team",y="Shots on target per shots taken")


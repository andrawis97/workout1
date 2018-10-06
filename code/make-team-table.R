library(readr)
library(dplyr)
dat <-read_csv("../data/nba2018.csv",col_types =
                 cols(player =col_character(),
                      position =col_factor(c('C','PF','PG','SF','SG'))))                                                                        
#correcting rookies
dat$experience[dat$experience == "R"] = 0
dat$experience <- as.integer(dat$experience)
#rounding salary
dat$salary <- round(dat$salary/1000000,2)
#adjusting position labels
dat$position <- factor(dat$position, labels = c("center","power_fwd","point_guard","small_fwd","shoot_guard"))
#adding new variables
dat <- dat %>% mutate(missed_fg = field_goals_atts - field_goals)
dat <- dat %>% mutate(missed_ft = points1_atts - points1)
dat <- dat %>% mutate(rebounds = off_rebounds + def_rebounds)
dat <- dat %>% mutate(efficiency = (points + rebounds + assists + steals + blocks - missed_fg - missed_ft - turnovers) / games)
#sink summary efficiency.txt
sink(file = "../output/efficiency-summary.txt")
summary(dat$efficiency)
sink()
#data aggregation
teams <- dat %>% group_by(team) %>% summarise( experience = sum(experience),
                                      salary = round(sum(salary),2),
                                      points3 = sum(points3),
                                      points2= sum(points2),
                                      points1= sum(points1),
                                      points = sum(field_goals,points3,points2,points1),
                                      off_rebounds = sum(off_rebounds),
                                      def_rebounds = sum(def_rebounds),
                                      assists = sum(assists),
                                      steals = sum(steals),
                                      blocks = sum(blocks),
                                      turnovers = sum(turnovers),
                                      fouls = sum(fouls),
                                      efficiency = sum(efficiency))
#extra code to make sure the tibble prints completely
options(tibble.width = Inf)
options(tibble.print_max = Inf)
#sink teams summary
sink(file = "../data/teams-summary.txt")
teams
sink()
#export team into csv
write.csv(teams , file = "../data/nba2018-teams.csv")

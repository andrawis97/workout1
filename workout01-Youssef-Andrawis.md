Workout 1
================

``` r
library(readr)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
setwd("C:/Users/andra/OneDrive/Desktop/Berkeley/stat133-fall-2018-master/hws/workout01/code")
teams <- read.csv(file = "../data/nba2018-teams.csv")
```

``` r
library(ggplot2)

ggplot(teams, aes(x= reorder(team, salary), y = salary)) + geom_bar(stat= 'identity') +coord_flip() + ylab("Salary (in Millions)") + xlab("Team") + geom_hline(aes(mean(teams$salary)), yintercept = mean(teams$salary), col = 'red', size = 2)
```

![](workout01-Youssef-Andrawis_files/figure-markdown_github/barplot%20salary-1.png)

``` r
ggplot(teams, aes(x= reorder(team, points), y = points)) + geom_bar(stat= 'identity') +coord_flip() + ylab("Points") + xlab("Team") + geom_hline(aes(mean(teams$points)), yintercept = mean(teams$points), col = 'red', size = 2)
```

![](workout01-Youssef-Andrawis_files/figure-markdown_github/barplot%20points1-1.png)

``` r
ggplot(teams, aes(x= reorder(team, efficiency), y = efficiency)) + geom_bar(stat= 'identity') +coord_flip() + ylab("efficiency") + xlab("Team") + geom_hline(aes(mean(teams$efficiency)), yintercept = mean(teams$efficiency), col = 'red', size = 2)
```

![](workout01-Youssef-Andrawis_files/figure-markdown_github/barplot%20efficiency-1.png)

``` r
teams_2 <- mutate(teams, possesion_efficiency = ((steals+def_rebounds) - (turnovers)) / 82)
ggplot(teams_2, aes(x= reorder(team, possesion_efficiency), y = possesion_efficiency)) + geom_bar(stat= 'identity') +coord_flip() + ylab("Possesion Efficiency") + xlab("Team") + geom_hline(aes(mean(teams_2$ppossesion_efficiency)), yintercept = mean(teams_2$possesion_efficiency), col = 'red', size = 2)
```

![](workout01-Youssef-Andrawis_files/figure-markdown_github/barplot%20possession-1.png)

the metric I came up with aggregates steals and def\_rebounds and deducts turnovers and fouls from that. I then get the average per game to see how often the team is able to get possesion back from the other team. this should be an an indicator of how often the team is attacking and therefore should have more oppurtunity to score.

comments and reflection
=======================

1.  Was this your first time working on a project with such file structure? If yes, how doyou feel about it?
    1.  No, it was easy. 2.Was this your first time using relative paths? If yes, can you tell why they are important for reproducibility purposes?
    2.  No, but they are important to make sure someone can run your code by having the same Working directory
2.  Was this your first time using an R script? If yes, what do you think about just writing code (without markdown syntax)?
    1.  No, its cool but definetly a shift from traditional .Rmd which we learned on
3.  What things were hard, even though you saw them in class/lab?
    1.  the horizonal bar graph with the line
4.  What was easy(-ish) even though we haven't done it in class/lab?
    1.  re-ordering the data when arrange didnt work
5.  Did anyone help you completing the assignment? If so, who?
    1.  No, but I used piazza if that counts
6.  How much time did it take to complete this HW?
    1.  about 4 hours
7.  What was the most time consuming part?
    1.  Data Dictionary 9.Was there anything interesting?
    2.  Coming up with my own metric was cool and stimulated a very interesting disucssion amongst my sports fan friends who I consulted on Basketball rules since I'm not a regular of the game.

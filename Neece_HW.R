### QM Week 5: Coding in R III

## Authors: Jillian Neece. Collaborated with Maddie Tedder

######################################

## Set up ##
library(tidyverse)
library(readxl)
library(writexl)

## Problem 1 ##

#reading in .csv file
fish.csv <- read.csv("HW/Data/fish.csv")
#head prints the first n rows
head(fish.csv, n=5)

#reading in .xlsx file using readxl package
fish.xlsx <- read_excel("HW/Data/fish.xlsx")
head(fish.xlsx, n=5)

#reading in .rds file
fish.rds <- readRDS("HW/Data/fish.rds")
head(fish.rds, n=5)


## Problem 2 ##

fish.save.csv <- write.csv(fish.csv,"HW/Data/Output/fish.csv")
fish.save.xlsx <- write_xlsx(fish.csv, "HW/Data/Output/fish.xlsx")
fish.save.rds <- saveRDS(fish.csv, "HW/Data/Output/fish.rds")

file.info(c("HW/Data/Output/fish.csv", 
            "HW/Data/Output/fish.xlsx", 
            "HW/Data/Output/fish.rds"))

## Since the .rds is the smallest file, it would probably be the best for
## compact storage. The .csv and .xlsx are larger files, so they would not be 
## ideal for compact storage, but they would be usable outside of R, so they
## could be better for sharing files. I personally prefer to share .csv files 
## since I find them to be the simplest to work with. 

## Problem 3 ## 

## Task 1
fish.csv |> 
  filter(Lake == c("Erie", "Michigan")) |>
    filter(Species == "Walleye" |Species ==  "Yellow Perch" | Species == "Smallmouth Bass") |>
  select(Species, Lake, Year, Length_cm, Weight_g) |>
## Task 2
  group_by(Species) |> 
  mutate(Length_mm = Length_cm *10) |>
  mutate(Length_group = cut(Length_mm, 
                            breaks = c(0,200, 400, 600, 10000), 
                            labels = c("<200", "200-400", "400-600", ">600"))) |>
  group_by(Species, Length_group) |>
  summarize(count = n()) #couldn't figure out how to print the count of species x lenght_group
#while maintaining the pipeline, so I'm going to start a new one for the next task

## Task 3
fish_output <- fish.csv |>
  group_by(Species, Year) |>
  summarize(mean.weight = mean(Weight_g), 
            median.weight = median(Weight_g), 
            sample.size = n())
write.csv(fish_output, "HW/Data/Output/fish_output.csv")


## Problem 4 ##

multiple.files <- list.files("HW/Data/Multiple_files", full.names = TRUE)

fish.all <- lapply(multiple.files, read.csv)
fish.all.df <- bind_rows(fish.all)


## Problem 5 ##

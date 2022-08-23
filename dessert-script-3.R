library(here)
library(tidyverse)
library(rvest)

our_desserts <- read_csv(here("favorite_desserts.csv"))

our_desserts <- our_desserts %>% 
  rename(dessert = Favorite_dessert)

iconic_desserts <- read_csv(here("iconic_desserts.csv"))

#finding which of our desserts are iconic with a left join:

our_iconic_deserts <- left_join(x = our_desserts, y = iconic_desserts) %>% 
  replace_na(list(first_name = NA, last_name = NA, dessert = NA, rank = "NOT ICONIC"))





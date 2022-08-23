library(here)
library(tidyverse)
library(rvest)
library(janitor)
library(sqldf)

our_desserts <- read_csv(here("favorite_desserts.csv")) %>% 
  clean_names()

our_desserts <- our_desserts %>% 
  rename(dessert = favorite_dessert) %>% 
  mutate(dessert = tolower(dessert))

iconic_desserts <- read_csv(here("iconic_desserts.csv")) %>% 
  clean_names() %>% 
  mutate(dessert = tolower(dessert))

#finding which of our desserts are iconic with a semi join:

our_iconic_deserts <- semi_join(x = our_desserts, y = iconic_desserts) %>% 
  mutate(rank = replace_na("UR ICONIC"))

#find out which desserts are iconic with a for loop

# Test with no matches
matches <- c()

for (i in seq_along(our_desserts$dessert)) {
  for (j in seq_along(iconic_desserts$dessert)) {
    if (our_desserts$dessert[i] == iconic_desserts$dessert[j]) {
      matches <- append(matches, our_desserts$dessert[i])
    }
  }
}

if (length(matches) == 0) {
  message("No matches.")
}

if (length(matches) != 0) {
  print(matches_test)
}

# should output No matches.

# Now using the sqldf package
#are_we_iconic <- sqldf('SELECT * FROM our_desserts INTERSECT SELECT * FROM iconic_desserts')
#getting Error: SELECTs to the left and right of INTERSECT do not have the same number of result columns


#finding iconic desserts with generics::intersect

#matching_desserts <- generics::intersect(x = our_desserts, y = iconic_desserts)
#Error:`x` and `y` are not compatible. (need to have same number of columns)




#Using filter:

dessert_match2 <- our_desserts %>% 
  filter(dessert %in% iconic_desserts$dessert)

#try using 


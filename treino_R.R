library(nycflights13)
library(tidyverse)
library(dplyr)

nycflights13::flights

glimpse(flights)

flights |> 
  filter(dest == "IAH") |> 
  group_by(year, month, day) |> 
  summarize(
    arr_delay = mean(arr_delay, na.rm=TRUE)
  )
  

flights |> 
  filter(month == 1 | month == 2)

flights |> 
  arrange(dep_delay)


flights |> 
  distinct(origin, dest)


flights |> 
  count(origin, dest, sort = TRUE)

flights |> 
  filter(arr_delay > 120)

flights |> 
  filter(dest == c("HOU", "IAH"))
         
flights |> 
  filter( carrier == c("AA", "UA", "DL"))

flights |> 
  filter(month == c(7, 8 ,9))

flights |> 
  filter(arr_delay > 120 & dep_delay <= 0)

flights |> 
  filter(arr_delay > 60 & air_time > 30)
  
flights |> 
  arrange(desc(dep_delay))

flights |> 
  arrange(distance/(air_time))

flights |> 
  distinct(month, day)


flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance/air_time * 100,
    hours = air_time/60,
    gain_per_hour = gain/hours,
  .keep = 'used'
  )


flights |> 
  relocate(year:dep_time, .after = time_hour)
flights |> 
  relocate(starts_with("arr"), .before = dep_time)


flights |> 
  select(dep_time, sched_dep_time, dep_delay)

flights |> 
  select(arr_time, arr_time, arr_time)

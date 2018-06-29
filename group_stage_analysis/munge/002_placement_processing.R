
wc.summary.clean <- wc.summary %>%
  rename(
    year = Year,
    host = Country,
    winner  = Winner, 
    runner_up = `Runners-Up`,
    third = Third,
    fourth = Fourth,
    teams = QualifiedTeams) %>%
  select(year, host, teams, winner, runner_up, third, fourth) 

wc.summary.tidy <- wc.summary.clean %>%
  # tidy dataset into placements at worldcups
  gather('placement_label','team', 4:7) %>%
  
  # convert placement to a rank integer (1st...4th)
  
  mutate(placement = ifelse(placement_label == "winner", 1,
                            ifelse(placement_label == 'runner_up', 2, 
                                   ifelse(placement_label == "third", 3, 4))))



rmarkdown::render("munge/placement_processing_notes.rmd")



wc.groupstage.tidy <- wc.matches %>%
  rename(year = Year,
         date = Datetime,
         stage = Stage, 
         home = `Home Team Name`,
         away = `Away Team Name`,
         home_goals = `Home Team Goals`,
         away_goals = `Away Team Goals`) %>%
  select(year, date, stage, home, away, home_goals, away_goals) %>%
  
  # convert wide per match data format to skinny per team format. 
  gather("where", "team", c(home, away)) 
  
wc.groupstage.results <- wc.groupstage.tidy %>% 
  # Create new fields: calc per team metrics from match level metrics
  mutate(
        # work out from goals for vs agaist who won the match
        # assign points so we can compare track records. 
        result =  ifelse(  (where == "home" & home_goals > away_goals)|
                            (where == "away" & away_goals > home_goals), 3,
                            ifelse(home_goals==away_goals, 1,
                            0)),
         
         # assign goals per team rather than by match. 
         goals_scored = ifelse(where=="home", home_goals, away_goals),
         goals_conceded = ifelse(where=="home", away_goals, home_goals),
         
         # label whether a match was in group stage or not.
         
         group_stage = ifelse(grepl("Group", stage),TRUE, FALSE)) %>%
  # dataset has many NA rows - remove these. 
  # we're only interested in group stage goals. 
  filter(!is.na(year), 
        group_stage == TRUE) 
  
  wc.groupstage.totals <- wc.groupstage.results %>%
  # remove intermediary columns 
  select(-home_goals, -away_goals, -group_stage) %>%
  group_by(team, year) %>%
  summarise(points_total = sum(result),
            goals_scored = sum(goals_scored),
            goals_conceded = sum(goals_conceded),
            group_name = first(stage)) %>%
  ungroup() %>%
  group_by(year, group_name) %>%
  # rank teams within group by points total
  # tiny but effective hack -(points total) instead of desc (not working)
  arrange(year, group_name, -(points_total)) %>%
  mutate(points_rank=row_number()) %>%
  # repeat 51 - 53 for goals scored and conceded
  arrange(year, group_name, -(goals_scored)) %>%
  mutate(goals_scored_rank = row_number()) %>%
  arrange(year, group_name, goals_conceded) %>%
  mutate(goals_conceded_rank = row_number()) 
  
  
    

  
rmarkdown::render("munge/groupstage_processing_notes.rmd")
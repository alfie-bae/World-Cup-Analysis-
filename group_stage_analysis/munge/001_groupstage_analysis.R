
'
Part 1: convert match results to team results for the group stage. 
 
input - match data - home team, away team, home goals, away goals, stage. 
output - team data - goals scored, goals conceded, won, points. 
                   - non-group stage matches are to be removed. 

'

wc.groupstage <- wc.matches %>%
  rename(year = Year,
         date = Datetime,
         stage = Stage, 
         home = `Home Team Name`,
         away = `Away Team Name`,
         home_goals = `Home Team Goals`,
         away_goals = `Away Team Goals`) %>%
  select(year, date, stage, home, away, home_goals, away_goals) %>%
  
  # convert wide per match data format to skinny per team format. 
  gather("where", "team", c(home, away)) %>%
  
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
         group_stage = ifelse(grepl("Group", stage), TRUE, FALSE)) %>%
  
  # dataset has many NA rows - remove these. 
  # we're only interested in group stage goals. 
  filter(!is.na(year), 
        group_stage == TRUE) %>%
  
  # remove intermediary columns 
  select(-home_goals, -away_goals, -group_stage)


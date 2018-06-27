
# new-project

wc.details <- left_join(x=wc.matches.tidy,
                        y=wc.summary.clean,
                        by="year") %>%
  
  # final_position 
  
  mutate(placement = ifelse(team == cup_winner, "winner", 
                            ifelse(team==cup_runners_up, "runner_up",
                            ifelse(team==cup_third|team==cup_fourth, "semi-final", "unranked"))))


group_position <- wc.matches.tidy %>%
  group_by(year, stage, team) %>%
  summarise(group_points = sum(result)) %>%
  ungroup(team) %>%
  summarise(rk = rank(group_points))

# writes result to googlesheet 


# does it matter -
# group stage points (how well in gstage) 
# goals scored
# goals conceded. 

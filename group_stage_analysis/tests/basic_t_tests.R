
wc.combined <- wc.groupstage.totals %>%
  left_join(wc.summary.tidy, by=c("year", "team")) %>%
  mutate(placement_label = ifelse(is.na(placement_label), "no rank", placement_label),
         winner = ifelse(placement_label == "winner", 1, 0),
         top4  =  ifelse(placement_label %in% c("winner", "runner_up", "third", "fourth"), 1,0))


stats.points.winning <- t.test(x = wc.combined$points_total,
                            y = wc.combined$winner,
                            p.value=0.1)$p.value

stats.points.top4 <- t.test(x = wc.combined$points_total,
                            y = wc.combined$top4,
                            p.value=0.1)$p.value

stats.scored.winning <- t.test(x = wc.combined$goals_scored,
                            y = wc.combined$winner,
                            p.value=0.1)$p.value

stats.scored.top4 <- t.test(x = wc.combined$goals_scored,
                            y = wc.combined$winner,
                            p.value=0.1)$p.value

stats.conceded.winning <- t.test(x = wc.combined$goals_conceded,
                            y = wc.combined$winner,
                            p.value=0.1)$p.value

stats.conceded.top4 <- t.test(x = wc.combined$goals_conceded,
                            y = wc.combined$winner,
                            p.value=0.1)$p.value







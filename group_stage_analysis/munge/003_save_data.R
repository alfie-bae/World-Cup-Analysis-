
write_csv(wc.groupstage.totals, "data/products/wc_groupstage.csv")
write_csv(wc.summary.tidy, "data/products/wc_placements.csv")

xx = data_frame("variable"=c("points won", "points won", "goals scored", "goals scored", "goals conceded", "goals conceded"),
           "placement"=c("winner", "top four", "winner", "top four", "winner", "top four"),
           "correlation"=c(0.962, 0.981, 0.915, 0.958, -0.866, -0.907),
           "p value (%)"=c(0.0001, 0.0006, 0.07, 0.005, 0.3, 0.09))
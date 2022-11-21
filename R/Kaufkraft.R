library(tidyverse)
library(scales)
library(plotly)
rate <- c(.02,.04,.06,.08,.1)
periode <- c(0:50)
grid <- expand.grid(rate,periode) %>%
  rename(Rate=Var1,Periode=Var2)
df_plot <- grid %>%
  mutate(Kaufkraft=(1-Rate)^Periode,
         Inflationsrate=factor(Rate,labels = c('2%','4%','6%','8%','10%'))
  )


#p <- df_plot %>%
#        ggplot(aes(x=Periode,y=Kaufkraft,color=Inflationsrate)) +
#           geom_line(stat='identity',size=1.1) +
#           scale_y_continuous(labels= scales::percent_format(accuracy #= 1)) +
#           ylab("Kaufkraft (in % von Periode 1)") +
#           guides(color=guide_legend("Inflationsrate (p.a.)")) +
#           theme_light() +
#           theme(legend.position = 'bottom')
#p
p <- df_plot %>%
  plot_ly(x = ~Periode, y = ~Kaufkraft, color = ~Inflationsrate,
          width=700, height=480) %>%
  add_lines()  %>%
  layout(xaxis=list(title="Periode"),
         yaxis=list(tickformat = ".1%",
                    title="Kaufkraft (in % Periode 1)")
  )

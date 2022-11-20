# Data description -----
desc <- head(get_description("ICP.M.DE.N.000000+XEF000.4.ANR"), 3)
strwrap(desc, width = 80)


# load data -----
year <- '2022'
my_in_file<-glue('inflation_raw_{year}.rds')
load(file=xfun::from_root("data","raw",my_in_file))


## Data Wrangling -----
plot_df <- inflation %>%
                mutate(date=convert_dates(obstime),
                       var=factor(icp_item,labels = c("HVPI","Kerninflation")),
                       rate=obsvalue
                      ) %>%
            select(date,var,rate)


# Dataviz -----

#Headline vs. Core-Inflation ------
p <- plot_df %>%
    #    filter(obstime>2015) %>%
        ggplot(aes(x=date,y=rate,fill=var)) +
        geom_bar(stat="identity",position="dodge") +
        scale_x_date(date_breaks = "1 year", date_minor_breaks = "1 month",
                     date_labels = "%b/%Y") +
        scale_y_continuous(breaks = seq(0,10,2)) +
        labs(x="Zeit",y="Inflationsrate (in %)") +
        theme_light() +
        theme(legend.title=element_blank(), legend.position = "bottom",
              legend.text = element_text(size=18),
              axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1,size=15),
              axis.text.y = element_text(size=15),
              axis.title.x = element_text(size = 18),
              axis.title.y = element_text(size = 18)
              )
p
plotly::ggplotly(p)


inflation %>%
  mutate(date=convert_dates(obstime)) %>%
  #    filter(obstime>2015) %>%
  ggplot(aes(x=date,y=obsvalue,color=icp_item)) +
  geom_line()

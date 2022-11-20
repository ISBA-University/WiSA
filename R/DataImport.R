source(xfun::from_root("R/package-loading.R"))
# Headline- und Kerninflation ----
inflation <- get_data("ICP.M.DE.N.000000+XEF000.4.ANR",
                  filter = list(startPeriod = "2000"))


## tibble im "raw data Ordner" speichern ----
year<-'2022'

## save data ----
my_out_file<-glue('inflation_raw_{year}.rds')
save(inflation,file=xfun::from_root("data","raw",my_out_file))

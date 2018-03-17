library(readr)
library(dplyr)
library(dbplyr)
library(DBI)
library(RSQLite)

adm1_provincias <- read_csv("data/divisiones/csv/adm1-provincias.csv",
                     col_types = list(
                       Código = col_integer(),
                       Nombre = col_character()
                     ))

adm2_cantones <- read_csv("data/divisiones/csv/adm2-cantones.csv",
                     col_types = list(
                        Código = col_integer(),
                        Provincia = col_integer(),
                        Nombre = col_character(),
                        `Área (km2)` = col_double(),
                        `Pop. (2008)` = col_integer()
                     ))

adm2_gadm <- read_csv("data/divisiones/csv/adm2-gadm.csv",
                     col_types = list(
                        ID_2 = col_integer(),
                        Código = col_integer()
                     ))

adm3_distritos <- read_csv("data/divisiones/csv/adm3-distritos.csv",
                     col_types = list(
                        Código = col_integer(),
                        Cantón = col_integer(),
                        Nombre = col_character()
                     ))

divisiones <- dbConnect(RSQLite::SQLite(), "data/divisiones/divisiones.sqlite")

dbWriteTable(divisiones, "adm1_provincias", adm1_provincias)
dbWriteTable(divisiones, "adm2_cantones", adm2_cantones)
dbWriteTable(divisiones, "adm2_gadm", adm2_gadm)
dbWriteTable(divisiones, "adm3_distritos", adm3_distritos)

dbDisconnect(divisiones)

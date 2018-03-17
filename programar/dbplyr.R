library(readr)
library(dplyr)
library(dbplyr)
library(DBI)
library(RSQLite)

divisiones <- dbConnect(RSQLite::SQLite(), "data/divisiones/divisiones.sqlite")

dbListTables(divisiones)


# con solo RSQLite podemos hacer queries
dbGetQuery(divisiones, 'SELECT * FROM adm2_cantones LIMIT 10')

# Pero podemos hacer lo mismo con dplyr

# primero hacemos una coneccion al cuadro de interes

adm2_cantones_db <- tbl(divisiones, "adm2_cantones")

# Esto crea un objeto que no hemos visto antes
adm2_cantones_db

class(adm2_cantones_db)

View(adm2_cantones_db)

adm2_cantones_col <- collect(adm2_cantones_db)

class(adm2_cantones_col)

View(adm2_cantones_col)

# La fila de los primeros diez
#
adm2_cantones_db %>%
  head(10)

# Unir tablas de la base de datos ----
dbListTables(divisiones)

adm1_provincias_db <- tbl(divisiones, "adm1_provincias")
adm2_cantones_db <- tbl(divisiones, "adm2_cantones")
adm2_gadm_db <- tbl(divisiones, "adm2_gadm")
adm3_distritos_db <- tbl(divisiones, "adm3_distritos")

adm2_cantones_db %>%
  left_join(adm2_gadm_db, by = c("Código" = "Código"))

cuadro_unido <- adm2_cantones_db %>%
  left_join(adm2_gadm_db, by = c("Código" = "Código"))

explain(cuadro_unido)

dim(cuadro_unido)

dim(collect(cuadro_unido))

# Filtrar sobre una tabla
cuadro_unido %>%
  filter(Código > 200)

# Cuando usar collect?
cuadro_unido$Código
cuadro_unido$Nombre

collect(cuadro_unido)$Nombre

# O en el dataducto
cuadro_unido %>%
  select(Nombre) %>%
  collect() %>%
  unlist() %>% unname()

# Desconectar de la base de datos ----
dbDisconnect(divisiones)

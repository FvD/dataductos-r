library(dplyr)
library(readr)

# Leer datos ----
codes <- read_csv("data/reciclaje/costarica-codes.csv",
                     col_types = list(
                       ID_2 = col_integer(),
                       code = col_integer()
                     ))

basura <- read_csv("data/reciclaje/costarica-garbage.csv",
                     col_types = list(
                       PROVINCIA = col_character(),
                       `COD PROVINCIA` = col_integer(),
                       `Gran Área Metropo.` = col_integer(),
                       ID = col_integer(),
                       Cantón = col_character(),
                       `Total toneladas de residuos por mes` = col_character(),
                       `Toneladas de residuos valorizables por mes` = col_character(),
                       `Porcentaje de valorizables del total` = col_character(),
                       `Recoge residuos por separado en casas (total o parcialmente en el cantón)` = col_character(),
                       `Tiene programas de reciclaje al menos 1 vez al mes` = col_character(),
                       `Porcentaje de hogares que separan` = col_character()
                     ))


indices <- read_csv("data/reciclaje/costarica-indices.csv",
                     col_types = list(
                       code = col_integer(),
                       `human development index` = col_integer(),
                       `human development percentage` = col_integer(),
                       `education index` = col_integer(),
                       `education percentage` = col_integer(),
                       `life expectancy index` = col_integer(),
                       `life expectancy percentage` = col_integer()
                     ))


# Cuantos datos tenemos? ----
dim(codes)
dim(basura)
dim(indices)

# Nota que readr convirtió todo a tibles
basura

as.data.frame(basura)

head(as.data.frame(basura))

head(basura)

# Como unimos esto a un cuadro ordenado? ----

codes
basura
indices

# como sabemos si todos los basura$codes estan en indices$codes ----
# semi_join: Útil para ver que se va a unir
basura %>%
  semi_join(indices, by = c("ID" = "code")) %>%
  dim()

indices %>%
  semi_join(basura, by = c("code" = "ID")) %>%
  dim()

# Antijoin: Útil para ver que no se va a unir
basura %>%
  anti_join(indices, by = c("ID" = "code")) %>%
  dim()

indices %>%
  anti_join(basura, by = c("code" = "ID")) %>%
  dim()

# Simulemos una union incompleta ----
basura_n <- sample_n(basura, 6)
indices_n <- sample_n(indices, 4)

basura_n %>%
  semi_join(indices_n, by = c("ID" = "code")) %>%
  dim()

indices_n %>%
  semi_join(basura_n, by = c("code" = "ID")) %>%
  dim()

basura_n %>%
  anti_join(indices_n, by = c("ID" = "code")) %>%
  dim()

indices_n %>%
  anti_join(basura_n, by = c("code" = "ID")) %>%
  dim()

# El mas comun: left_join
# Quiro todo a la izquierda con lo que encuentres a la derecha
basura_n
indices_n

basura_n %>%
  left_join(indices_n, by = c("ID" = "code")) %>%
  select(PROVINCIA, `human development percentage`)

# Otro comun: inner_join
basura_n %>%
  inner_join(indices_n, by = c("ID" = "code")) %>%
  select(PROVINCIA, `human development percentage`)

# Menos comun right join y full join
basura_n %>%
  right_join(indices_n, by = c("ID" = "code")) %>%
  select(PROVINCIA, `human development percentage`)

basura_n %>%
  full_join(indices_n, by = c("ID" = "code")) %>%
  select(PROVINCIA, `human development percentage`)

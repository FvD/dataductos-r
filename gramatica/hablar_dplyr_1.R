library(dplyr)
library(readr)


salarios <- read_csv("data/salarios/ccss_salarios.csv",
                     col_types = list(
                       No. = col_integer(),
                       OCUPACION = col_integer(),
                       OCUPACION.NOMBRE = col_character(),
                       SALARIO = col_double()
                     ))

# Cuantos datos tenemos?
dim(salarios)

# Los 5 verbos principales
# filter, select, mutate, arrange y summarise, y adverbio "by group"

# Cuantas ocupaciones hay en los datos?
salarios %>%
  group_by(OCUPACION, OCUPACION.NOMBRE) %>%
  summarise(n = n())


# Cual es el salario promedio
salarios %>%
  group_by(OCUPACION, OCUPACION.NOMBRE) %>%
  summarise(salario_prom = mean(SALARIO))


# Cual es el Top 10 de los salarios?
salarios %>%
  group_by(OCUPACION, OCUPACION.NOMBRE) %>%
  summarise(salario_prom = mean(SALARIO)) %>%
  arrange(desc(salario_prom))


# Solo seleccionar los jefes
library(stringr)
salarios %>%
  filter(str_detect(OCUPACION.NOMBRE, "Jefe"))


# Crear columna indicando si alguien es Jefe o No
# NOTA: Usamos dplyr::if_else y no ifelse
salarios %>%
  mutate(
    JEFE = if_else(
      str_detect(OCUPACION.NOMBRE, "Jefe"),  1,  0)
    )

# Convertir los datos a una variante con codigos
salarios %>%
  mutate(
    JEFE = case_when(
      str_detect(OCUPACION.NOMBRE, "Jefe") ~ 1,
      str_detect(OCUPACION.NOMBRE, "Técnico") ~ 2,
      str_detect(OCUPACION.NOMBRE, "Supervisor") ~ 3,
      str_detect(OCUPACION.NOMBRE, "Médico") ~ 5,
      str_detect(OCUPACION.NOMBRE, "Operador") ~ 6
    )
  ) %>%
  filter(!is.na(JEFE)) %>%
  select(OCUPACION, SALARIO, JEFE)


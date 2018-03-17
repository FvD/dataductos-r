# Basado en charla de Lionel Henry sobre tidy evaluation
# https://www.rstudio.com/resources/webinars/tidy-eval/

divisiones <- dbConnect(RSQLite::SQLite(), "data/divisiones/divisiones.sqlite")

# Aplanamos el cuadro adm2_cantones a un tibble
cantones <- tbl(divisiones, "adm2_cantones") %>%
  collect() %>%
  rename(codigo = Código) %>%
  rename(area = `Área (km2)`) %>%
  rename(poblacion = `Pop. (2008)`)

# esto funciona
transmute(cantones, poblacion / area)

# pero esto no
poblacion / area

# esto si
cantones$poblacion / cantones$area

# esto no da error
quote(poblacion / area)

x <- quote(poblacion / area)

# pero esto si
eval(x)

# evaluate in data mask
eval(x, cantones)


# asi que una función como transmute evaluan en un data mask
# pero no podemos pasarlo directamente
transmute(cantones, x)

# tenemos que usar el operador bang bang
transmute(cantones, !!x)

# a veces nos perdemos, y la ultima version de rlang tienen la funcion qq_show
# verificar con qq_show
qq_show(
  transmute(cantones, x)
)

# tenemos que usar el operador bang bang
qq_show(
   transmute(cantones, !!x)
)


# Crear simbolos
columnas <- c("poblacion", "area")

columna <- columnas[[1]]

cantones %>%
  summarise(avg = mean(columna, na.rm = TRUE))

cantones %>%
  summarise(avg = mean(!!columna, na.rm = TRUE))

# Necesitamos una alternativa a un string: Simbolos
columna <- sym(columnas[[1]])

cantones %>%
  summarise(avg = mean(!!columna, na.rm = TRUE))


# Con esto podemos programar
for (i in seq(1, length(columnas))) {
  columna <- sym(columnas[[i]])
  resultado <- cantones %>%
    summarise(avg = mean(!!columna, na.rm = TRUE))
  print(resultado)
}

calcula_promedio <- function(datos, columna) {
  columna <- sym(columna)
  datos %>%
    summarise(avg = mean(!!columna, na.rm = TRUE))
}


calcula_promedio(cantones, "poblacion")
calcula_promedio(cantones, "area")

# Otros ejemplos

# select
cantones %>%
  select(columnas)

# triple Bang: "splice unqoute operator"
qq_show(
   cantones %>%
     select(columnas)
)

qq_show(
  cantones %>%
    select(!!!columnas)
)

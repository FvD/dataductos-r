# Algunos de los ejemplos que vimos durante la sesión pre-curso

# for Loops
for (i in seq(1, 5)) {
  cat("iteracion nr.", i, "\n")
}

# while
i <- 1
while (i <= 5) {
  cat("iteracion nr.", i, "\n")
  i <- i + 1
}

# repeat
i <- 0
repeat {
  i <- i + 1
  cat("iteracion nr.", i, "\n")
  if (i >= 5) break
}

# funciones
mi_funcion <- function() {
  print("hola")
}

mi_funcion <- function(nombre) {
  cat("hola", nombre)
}

mi_funcion <- function(nombre = "Data Latam") {
   cat("hola", nombre)
}

mi_funcion <- function(nombre = "Data Latam") {
   resultado <- paste("hola", nombre)
   return(resultado)
}


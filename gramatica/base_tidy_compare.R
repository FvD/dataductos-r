

# Crear subconjuntos
mtcars[which(mtcars$am == 0), ]
mtcars[which(mtcars$am == 1), ]



# recodificar una variable de dos niveles
# Estos ejemplos vienen de una charla de Mine Cetinkaya Rundel
# https://github.com/mine-cetinkaya-rundel/2017-07-05-teach-ds-to-new-user/blob/master/examples/base_tidy_compare.R

## R base

### opción 1
mtcars$transmission[mtcars$am == 0] = "automatico"
mtcars$transmission[mtcars$am == 1] = "manual"

### opción 2
mtcars$transmission <-
  ifelse(mtcars$am == 0,
         "automatico",
         "manual")

## tidyverse (dplyr)
library(dplyr)

### opción 1
mtcars <- mtcars %>%
  mutate(transmission =
    ifelse(am == 0, "automatico",
      ifelse(am == 1, "manual", am)))


### opción 2
mtcars <- mtcars %>%
  mutate(
    transmission =
      case_when(
        am == 0 ~ "automatic",
        am == 1 ~ "manual"
      )
  )

# recodificar variable con multiples niveles
## R base

### opción 1
mtcars$gear_char[mtcars$am == 3] = "three"
mtcars$gear_char[mtcars$am == 4] = "four"
mtcars$gear_char[mtcars$am == 5] = "five"

### opción 2
mtcars$gear_char <-
  ifelse(mtcars$gear == 3,
         "three",
         ifelse(mtcars$gear == 4,
                "four",
                "five")
  )

## tidyverse
mtcars <- mtcars %>%
  mutate(
    gear_char =
      case_when(
        gear == 3 ~ "three",
        gear == 4 ~ "four",
        gear == 5 ~ "five"
      )
  )


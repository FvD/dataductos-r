# Dataductos en R con dplyr

Estos son los ejemplos del [Curso Profesional: Dataductos en R con dplyr](https://www.meetup.com/DataLatam/events/243103581/).

Antes de comenzar con los ejemplos por favor verifica lo siguiente:

1. Que tienes una versión de R actualizada. Vamos a trabajar con la version 3.4.3. 
Para verificar la versión que tienes instalada puedes correr en la consola:

    > R.Version()$version.string

La respuesta debería ser por lo menos:

    [1] "R version 3.4.3 (2017-11-30)"

Si necesitas actualizar por favor visita la página correspondiente de r-project.org:

    https://cloud.r-project.org/

2. Que tienes una version de RStudio Actualizada. 

En RStudio busca la opción en el menu **Help >About RStudio**. Busca si tienes Versión 1.1.423 o mayor.
Si es menor instala una versión nueva ya sea con **Help > Check for Updates** o visitando las páginas de RStudio para bajar una nueva versión compatible con tu sistema:

    https://www.rstudio.com/products/rstudio/download/#download

3. Que tienes los paquetes necesarios 

Para que estes segur@ de tener todos los paquetes que vamos a utilizar lo mejor es que los instales de antemano. Con las siguientes instrucciones los puedes instalar todos:

    install.packages(c("devtools", "dplyr", "readxl", "readr", "lubridate", 
                "stringr", "purrr", "ggplot2", "DBI", "RSQLite", "tidyr"),
                 dependencies = TRUE)

## Organiza
Este evento lo organiza [Data Latam](http://wwww.datalatam.com) en cooperación con [ixpantia](https://www.ixpantia.com). Data Latam es una comunidad Latinoamericana de profesionales y académicos aplicando ciencia de datos en su día a día en la industria de datos en Latino América. En sus eventos, cursos y programas de extensión exploramos tecnologías, aprendemos sobre ciencia de datos, hablamos de tendencias y eventos relevantes de la industria, y compartimos novedades del sector.

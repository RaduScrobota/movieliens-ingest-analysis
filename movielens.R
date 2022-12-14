# ID SCRIPT ---------------------------------------------------------------

##LENGUAJES DE PROGRAMACIÓN ESTADÍSTICA
## PROFESOR: CHRISTIAN SUCUZHANAY AREVALO 
## ALUMNO: RADU SCROBOTA, EXP 21937899
## trabajo con DS de Movielens de Kaggle


# DATA INGESTION ----------------------------------------------------------

## Kaggle API:


# LOAD LIBRARY ------------------------------------------------------------

if(!require("pacman")) install.packages("pacman")
p_load(tidyverse, magrittr, janitor, lubridate)


# CLEAN AND FORMATTING ----------------------------------------------------

## Para que funcionaba as_tibble preguntar o buscar

m <- read_csv("ml-25m/movies.csv") %>%  as_tibble()
r <- read_csv("ml-25m/ratings.csv")  %>%  as_tibble()
t <- read_csv("ml-25m/tags.csv")  %>%  as_tibble()
l <- read_csv("ml-25m/links.csv")  %>%  as_tibble()

##Esto te limpia el dataset de dobles espacios antes de usar las expresiones regulares
str_squish()



# STATS,  EDA, PLAYING AROUND ---------------------------------------------

## miramos como estan los DS
t %>%  glimpse()
## usamos doble pipe para asi hacer los cambios y guardarlos 
t %<>%  mutate(timestamp= lubridate::as_datetime(timestamp)) %>% glimpse() %>%  view()
r %<>% mutate(timestamp= as_datetime(timestamp)) %>% glimpse() 
m %>%  glimpse() 
## queremos sacar del DS m en la columna de titulo la fecha y tenerla a parte, lo hacemos 
## con expresiones regulares

# extraemos de titulo y lo añadimos en una nueva columna llamada year
# despues de c("year") ponemos la expresion regular
m %<>% tidyr::extract(title, c("title1", "year"), "(.*) \\(([0-9]*)", remove = F)
# cambiamos el tipo de dato de year para que sea integer
m %<>%  mutate(year=as.integer(year)) 




# ESTADISTICAS BASICAS DE PELICULAS ---------------------------------------

## año cuando se han hecho mas peliculas
m %>% count(year, sort = T) 

## año cuando menos
m %>% count(year) 

## cuantos NA hay en el dataset de movies
sum(is.na(m))

## Grafico de como han crecido o decrecido las peliculas por año 

m %>% drop_na() %>% ggplot(aes(x = year, y=count))+ geom_line()

## Marcas
## gasolineras famosa (repsol) o acompañado de SA , S.A

## Franquicia
## Las demás







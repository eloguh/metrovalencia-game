library(stringdist)
library(stringi)
library(stringr)

#This is the file where we have every station
# lineas <- readLines("./functions/EstacionsMV.txt", encoding = "UTF-8")
lineas <- estaciones$nombre
limit_lineas <- length(lineas)
#Add some extraordinary names
extraordinary <- c("Plaza de Patraix", "Marítim - Serreria", "Facultats", "Plaça del Tossal",
                   "Palmaret", "Peris Aragó", "Campanar - La Fe")
correspondence <- c("Estació de Patraix",
                    "Estació de Marítim",
                    "Estació de Facultats - Manuel Broseta",
                    "Estació de Tossal del Rei",
                    "Estació d'Alboraia Palmaret",
                    "Estació d'Alboraia Peris Aragó",
                    "Estació de Campanar")
lineas <- c(lineas, extraordinary)

#Change or erase the prepositions, linking words, numbers and urbanistic words
comodin_words <- function(texto){
  buscar <- c(0:9,"Zero", "Un", "Dos", "Tres", "Quatre", "Cinc", "Sis", "Set", "Vuit",
              "Huit", "Uit", "Nou","Plaza", "Plaça ", "Avenida ","avenida","Avinguda ","avinguda", "ny", "Ayuntamiento ",
              "Calle", "Rambla","Estación ", "Estació ","Estacion ","Estacio ",
              "d'","fonteta ","Fonteta ","Fuente ", "Font ", "font ", "fuente ",
              "del ", "dels ", "de ", "dE ", "(?<![[:alpha:]])el ", "la ", "los ", "las ", "les ", "els ",
              "C ", "C/", "y ", " - ", "l'", "L'")
  reemplazar <- c("Cero ", "Uno ", "Dos ", "Tres ", "Cuatro ", "Cinco ", "Seis ", "Siete ", "Ocho ", "Nueve ",
                  "Cero ", "Uno ", "Dos ", "Tres ", "Cuatro ", "Cinco ", "Seis ", "Siete ", "Ocho ","Ocho ","Ocho ", "Nueve ",
                  "Pl ", "Pl ", "Av ","Av ","Av ","Av ", "n", "Ayto ", "", "Rbla ", "","","",
                  "", "", "Fte ", "Fte ","Fte ", "Fte ","Fte ", "Fte ","","", "","",
                  "","","","","","","","", "","-","", "")

  for (i in seq_along(buscar)) {
    texto <- str_replace_all(texto, regex(buscar[i], ignore_case = TRUE), reemplazar[i])
  }
  return(texto)
}

#Function for fixing the words
formal_text <- function(text){
  # Remove unnecessary words or use abbreviations
  text <- comodin_words(text)
  # Remove accents
  accents <- stri_trans_general(text, "latin-ascii")
  # Convert to lowercase
  lowercase <- tolower(accents)
  # Remove strange symbols
  nosymbols <- str_remove_all(lowercase, "[^a-zA-Z0-9- ]+")
  return(nosymbols)
}

#Function for finding coincidence between the input text and the stations
find_coincidence <- function(left, right){
  #Left: The text we want to find
  #Rigth: A vector where we want to search
  i = 1
  num_search = length(right)
  aprox <- stringdist(left, right, method = "dl")
  best <- which.min(aprox)
  if (aprox[best] < 3){
    return(best)
  }
  return(FALSE)
}

stations_rebuilt <- formal_text(lineas)

finding_station <- function(){
  input <- readline("Estacion: ")
  input_rebuilt <- formal_text(input)
  coincide <- find_coincidence(input_rebuilt,stations_rebuilt)
  if (is.numeric(coincide)){
    if (coincide > limit_lineas){
      good_coincide <- coincide - limit_lineas
      return(correspondence[good_coincide])
    }
    return(lineas[coincide])
  }
  return("No existe esa estacion")
}
finding_station()
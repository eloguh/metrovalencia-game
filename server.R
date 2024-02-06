server <- function(input, output, session) {
  # Metrovalencia: main map
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(provider = "CartoDB.PositronNoLabels") %>%  
      addPolylines(data = lineas, color = ~color, opacity = 1, weight = 7) %>% 
      addCircleMarkers(data = estaciones, lat = ~lat, lng = ~lng,
                       popup = ~nombre, color = "gray", fillColor = "white",
                       fillOpacity = 1, radius = 3, weight = 2) %>% 
      setView(lng = -0.38, lat = 39.475, zoom = 12)
  })
  
  # Update dynamically the size of maps' objects based on map zoom
  observeEvent(
    eventExpr = input$map_zoom, {
      leafletProxy(
        mapId = "map", 
        session = session) %>% 
        clearMarkers() %>%
        clearShapes() %>% 
        addPolylines(data = lineas, color = ~color, opacity = 1,
                     weight = case_when(input$map_zoom <=9 ~2, 
                                         input$map_zoom ==10 ~2, 
                                         input$map_zoom ==11 ~2, 
                                         input$map_zoom ==12 ~3, 
                                         input$map_zoom ==13 ~4, 
                                         input$map_zoom ==14 ~4, 
                                         input$map_zoom ==15 ~5, 
                                         input$map_zoom ==16 ~7, 
                                         input$map_zoom >=17 ~8)) %>% 
        addCircleMarkers(data=estaciones,lng = ~lng, lat = ~lat, 
                         radius = case_when(input$map_zoom <=9 ~1, 
                                            input$map_zoom ==10 ~2, 
                                            input$map_zoom ==11 ~2, 
                                            input$map_zoom ==12 ~3, 
                                            input$map_zoom ==13 ~4, 
                                            input$map_zoom ==14 ~6, 
                                            input$map_zoom ==15 ~7, 
                                            input$map_zoom ==16 ~9, 
                                            input$map_zoom >=17 ~10),
                         weight = case_when(input$map_zoom <=11 ~1, 
                                            input$map_zoom ==12 ~2, 
                                            input$map_zoom ==13 ~2, 
                                            input$map_zoom ==14 ~2, 
                                            input$map_zoom >=15 ~3),
                         popup = ~nombre, color = "gray",
                         fillColor = "white", fillOpacity = 1)
        
    }
  )
  
  # Clean the search input when the text is entered
    observeEvent(input$text, {
      updateSearchInput(session, "text", value = "")
      # Llamada a find_station y actualización del mapa
      station_index <- find_station(input$text)
      if (station_index != -99) {
        # Actualiza el mapa centrando en la estación encontrada
        leafletProxy("map", session = session) %>%
          setView(lng = estaciones$lng[station_index], lat = estaciones$lat[station_index], zoom = 14)
        
        # También podrías resaltar la estación de alguna manera
        # (por ejemplo, cambiando el color o el tamaño del marcador)
        leafletProxy("map", session = session) %>%
          clearMarkers() %>%
          addCircleMarkers(data = estaciones[station_index, ], 
                           popup = ~nombre, color = "red", fillColor = "red",
                           fillOpacity = 1, radius = 5, weight = 2)
      }
    })
    
    # Helper functions
    comodin_words <- function(texto){
      buscar <- c(0:9,"Zero", "Un", "Dos", "Tres", "Quatre", "Cinc", "Sis", "Set", "Vuit",
                  "Huit", "Uit", "Nou","Plaza", "Plaça ", "Avenida ","avenida","Avinguda ","avinguda", "ny", "Ayuntamiento ",
                  "Calle", "Rambla","Estación ", "Estació ","Estacion ","Estacio ",
                  "d'","fonteta ","Fonteta ","Fuente ", "Font ", "font ", "fuente ",
                  "del ", "dels ", "de ", "dE ", "(?<![[:alpha:]])el ", "la ", "los ", "las ", "les ", "els ",
                  "C ", "C/", "y ", " - ", "l'", "L'", "l·l")
      reemplazar <- c("Cero ", "Uno ", "Dos ", "Tres ", "Cuatro ", "Cinco ", "Seis ", "Siete ", "Ocho ", "Nueve ",
                      "Cero ", "Uno ", "Dos ", "Tres ", "Cuatro ", "Cinco ", "Seis ", "Siete ", "Ocho ","Ocho ","Ocho ", "Nueve ",
                      "Pl ", "Pl ", "Av ","Av ","Av ","Av ", "n", "Ayto ", "", "Rbla ", "","","",
                      "", "", "Fte ", "Fte ","Fte ", "Fte ","Fte ", "Fte ","","", "","",
                      "","","","","","","","", "","-","", "", "l")
      
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
      if (aprox[best] <= 1){
        return(best)
      }
      return(FALSE)
    }
    
    #### Finding function
    find_station <- function(input){
      lineas <- estaciones$nombre
      limit_lineas <- length(lineas)
      input_rebuilt <- formal_text(input)
      stations_rebuilt <- formal_text(lineas)
      
      coincide <- find_coincidence(input_rebuilt, stations_rebuilt)
      if (is.numeric(coincide)){
        if (coincide > limit_lineas){
          good_coincide <- coincide - limit_lineas
          return(coincide[good_coincide])
        }
        return(coincide)
      }
      return(-99)
    }
  
}
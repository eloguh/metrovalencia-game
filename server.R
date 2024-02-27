server <- function(input, output, session) {
  # Metrovalencia: main map
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(provider = "CartoDB.PositronNoLabels") %>%  
      addPolylines(data = lineas, color = ~color, opacity = 1, weight = 7) %>% 
      addCircleMarkers(data = estaciones_mod(), lat = ~lat, lng = ~lng,
                       popup = ~nombre, color = "gray", fillColor = ~fill,
                       fillOpacity = 1, radius = 3, weight = 2) %>% 
      setView(lng = -0.38, lat = 39.475, zoom = 12)
  })
  
  
  # Update dynamically the size of maps' objects based on map zoom; prueba
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
        addCircleMarkers(data=estaciones_mod(),lng = ~lng, lat = ~lat, 
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
                         fillColor = ~fill, fillOpacity = 1)
      
    }
  )
  
  # Check if the user guessed any station
  correct_guess <- reactiveValues()
  observeEvent(input$text, {
    station_id <- find_station(input$text)
    
    if (station_id != -99){
      # Clean the search input when the text is entered correctly
      updateSearchInput(session, "text", value = "")
      
      if (!(station_id %in% correct_guess$list)){
        correct_guess$list <- c(isolate(correct_guess$list), station_id)
        
        id_aciertos <- sapply(correct_guess$list, function(vec) vec[1])
        acertados <- data.frame(id = id_aciertos) %>%
          left_join(estaciones, by = "id")
        ptot <- tot_prct(acertados)
        pline <- line_prct(acertados)
        
        
        data <- data.frame(c(ptot, pline))
        
        output$frac1 <- renderText({
          # Puedes colocar cualquier contenido aquí, por ejemplo, una variable
          fr <- paste(pline$n_aciertos[1], "de", N_ESTACIONES_POR_LINEA[1])
          return(fr)
        })
        output$frac2 <- renderText({
          # Puedes colocar cualquier contenido aquí, por ejemplo, una variable
          fr <- paste(pline$n_aciertos[2], "de", N_ESTACIONES_POR_LINEA[2])
          return(fr)
        })
        output$frac3 <- renderText({
          # Puedes colocar cualquier contenido aquí, por ejemplo, una variable
          fr <- paste(pline$n_aciertos[3], "de", N_ESTACIONES_POR_LINEA[3])
          return(fr)
        })
        output$frac4 <- renderText({
          # Puedes colocar cualquier contenido aquí, por ejemplo, una variable
          fr <- paste(pline$n_aciertos[4], "de", N_ESTACIONES_POR_LINEA[4])
          return(fr)
        })
        output$frac5 <- renderText({
          # Puedes colocar cualquier contenido aquí, por ejemplo, una variable
          fr <- paste(pline$n_aciertos[5], "de", N_ESTACIONES_POR_LINEA[5])
          return(fr)
        })
        output$frac6 <- renderText({
          # Puedes colocar cualquier contenido aquí, por ejemplo, una variable
          fr <- paste(pline$n_aciertos[6], "de", N_ESTACIONES_POR_LINEA[6])
          return(fr)
        })
        output$frac7 <- renderText({
          # Puedes colocar cualquier contenido aquí, por ejemplo, una variable
          fr <- paste(pline$n_aciertos[7], "de", N_ESTACIONES_POR_LINEA[7])
          return(fr)
        })
        
        output$frac8 <- renderText({
          # Puedes colocar cualquier contenido aquí, por ejemplo, una variable
          fr <- paste(pline$n_aciertos[8], "de", N_ESTACIONES_POR_LINEA[8])
          return(fr)
        })
        output$frac9 <- renderText({
          # Puedes colocar cualquier contenido aquí, por ejemplo, una variable
          fr <- paste(pline$n_aciertos[9], "de", N_ESTACIONES_POR_LINEA[9])
          return(fr)
        })
        output$frac10 <- renderText({
          # Puedes colocar cualquier contenido aquí, por ejemplo, una variable
          fr <- paste(pline$n_aciertos[10], "de", N_ESTACIONES_POR_LINEA[10])
          return(fr)
        })
        
        observe({ 
          updateProgressBar(session, "progress", value = ptot)
          updateProgressBar(session, "progress1", value = pline$prct_aciertos[1])
          updateProgressBar(session, "progress2", value = pline$prct_aciertos[2])
          updateProgressBar(session, "progress3", value = pline$prct_aciertos[3])
          updateProgressBar(session, "progress4", value = pline$prct_aciertos[4])
          updateProgressBar(session, "progress5", value = pline$prct_aciertos[5])
          updateProgressBar(session, "progress6", value = pline$prct_aciertos[6])
          updateProgressBar(session, "progress7", value = pline$prct_aciertos[7])
          updateProgressBar(session, "progress8", value = pline$prct_aciertos[8])
          updateProgressBar(session, "progress9", value = pline$prct_aciertos[9])
          updateProgressBar(session, "progress10", value = pline$prct_aciertos[10])
        })
        
        station <- estaciones %>% filter(id == station_id)
        leafletProxy("map", session = session) %>%
          flyTo(lng = station$lng, lat = station$lat, zoom = 14)
      }
    }
  })
  
  estaciones_mod <- reactive({
    estaciones %>% 
      mutate(fill = ifelse(id %in% correct_guess$list, "red", fill))
  })
}
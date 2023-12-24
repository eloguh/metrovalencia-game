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
  # observeEvent(input$text, {updateSearchInput(session, "text", value = "")})
}
server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(provider = "CartoDB.PositronNoLabels") %>%  
      addPolylines(data = lineas, color = ~color, opacity = 1, weight = 10) %>% 
      addCircleMarkers(data = estaciones, lat = ~lat, lng = ~lng,
                       popup = ~nombre, color = "gray", fillColor = "white",
                       fillOpacity = 1, radius = 6, weight = 2) %>% 
      setView(lng = -0.38, lat = 39.475, zoom = 13)
  })
  
  # observeEvent(input$text, {print(input$text)})
  # observeEvent(input$text, {updateSearchInput(session, "text", value = "")})
}
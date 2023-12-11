library(readxl)
library(sf)
library(dplyr)
library(leaflet)

lineas <- read_sf("./data/lineas/lineas.shp")
estaciones <- read_excel("./data/estaciones.xlsx")

leaflet() %>%
  addProviderTiles(provider = "CartoDB.PositronNoLabels") %>%  
  addPolylines(data = lineas, color = ~color, opacity = 1, weight = 10) %>% 
  addCircleMarkers(data = estaciones, lat = ~lat, lng = ~lng,
                   popup = ~nombre, color = "gray", fillColor = "white",
                   fillOpacity = 1, radius = 6, weight = 2)



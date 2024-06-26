library(shiny)
library(shiny.fluent)
library(imola)
library(stringr)
library(dplyr)
library(readr)
library(leaflet)
library(glue)
library(purrr)
library(sf)
library(readxl)
library(shinyWidgets)
library(DT)
library(shinyjs)
library(htmlwidgets)
library(shinydashboard)
library(shinyalert)

N_TOTAL_ESTACIONES <- 147
N_ESTACIONES_POR_LINEA <- c(40, 33, 27, 33, 18, 21, 16, 4, 23, 8)
# Read data
lineas <- read_sf("./data/lineas/lineas.shp")
estaciones <- read_excel("./data/estaciones.xlsx") %>% 
  mutate(fill = "white")

source("./functions/find_station.R", local=T, encoding = "UTF-8")
source("./functions/calc_prct.R", local=T, encoding = "UTF-8")
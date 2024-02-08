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

# Read data
lineas <- read_sf("./data/lineas/lineas.shp")
estaciones <- read_excel("./data/estaciones.xlsx") %>% 
  mutate(fill = "white")

source("./functions/find_station.R", local=T, encoding = "UTF-8")
header <- flexPanel(
  id = "header",
  align_items = "center",
  flex = c(0, 0, 0),
  img(src = "./logo/datalab/trans_logo_light.png", style = "width: 120px"),
  div(
    Text(variant = "xLarge", "x", style="color: black;"), 
    style = "margin-right: 10px;"),
  img(src = "./logo/metrovalencia/metrovalencia.png", style = "width: 90px"),
  style = "box-shadow: 0 0 8px #000;"
)

sidebar <- div(
  id = "sidebar",
  Separator("Busca la estación"),
  searchInput( # iconProps = list(iconName = "TrainSolid"), validateOnLoad = F
    "text", btnSearch = icon("train-subway"), width = "100%"),
  Separator("Estaciones encontradas"),
  uiOutput('found_stations'),
  Separator("Información sobre la estación"),
)

footer <- flexPanel(
  id = "footer",
  justify_content = 'space-between',
  gap = "10px",
  Text(variant = "medium", "Built with ❤ by Datalab", block=TRUE)
)

ui <- gridPage(
  tags$head(tags$link(rel="stylesheet", href = "style.css")),
  template = "grail-left-sidebar",
  gap = "10px",
  
  header = header,
  sidebar = sidebar,
  content = div(id="content", leafletOutput('map', height = "100%")),
  footer = footer
)
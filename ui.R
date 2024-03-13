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
  Separator("Información sobre la estación")
  
)

sidebar_fake <- div(
  id = "sidebar",
  Separator("Busca la estación"),
  searchInput("text", btnSearch = icon("train-subway"), width = "100%"),
  Separator("Estaciones encontradas"),
  flexPanel(
    id = "tot_stats",
    style = "height:auto",
    div(textOutput("frac_t"), style = "margin-left: 5%; margin-bottom: 20.5px;"),
    progressBar(id = "progress-total", value = 0, display_pct = TRUE, status = "success")
  ),
  Separator(),
  
  flexPanel(
    id = "general_stats",
    flex = c(1),
    style = "display: flex; flex-direction: row;",
    tags$div(
      style = "display: flex; flex-direction: column;",
      img(src = "./img/lines/L1.svg", style = "width: 24px; height:24px; margin-bottom: 16px;"),
      img(src = "./img/lines/L2.svg", style = "width: 24px; height:24px; margin-bottom: 16px;"),
      img(src = "./img/lines/L3.svg", style = "width: 24px; height:24px; margin-bottom: 16px;"),
      img(src = "./img/lines/L4.svg", style = "width: 24px; height:24px; margin-bottom: 16px;"),
      img(src = "./img/lines/L5.svg", style = "width: 24px; height:24px; margin-bottom: 16px;"),
      img(src = "./img/lines/L6.svg", style = "width: 24px; height:24px; margin-bottom: 16px;"),
      img(src = "./img/lines/L7.svg", style = "width: 24px; height:24px; margin-bottom: 16px;"),
      img(src = "./img/lines/L8.svg", style = "width: 24px; height:24px; margin-bottom: 16px;"),
      img(src = "./img/lines/L9.svg", style = "width: 24px; height:24px; margin-bottom: 16px;"),
      img(src = "./img/lines/L10.svg", style = "width: 24px; height:24px; margin-bottom: 16px;")
    ),
    tags$div(
      style = "display: flex; flex-direction: column;",
      div(textOutput("frac1"), style = "margin-bottom: 20.5px;"),
      div(textOutput("frac2"), style = "margin-bottom: 20.5px;"),
      div(textOutput("frac3"), style = "margin-bottom: 20.5px;"),
      div(textOutput("frac4"), style = "margin-bottom: 20.5px;"),
      div(textOutput("frac5"), style = "margin-bottom: 20.5px;"),
      div(textOutput("frac6"), style = "margin-bottom: 20.5px;"),
      div(textOutput("frac7"), style = "margin-bottom: 20.5px;"),
      div(textOutput("frac8"), style = "margin-bottom: 20.5px;"),
      div(textOutput("frac9"), style = "margin-bottom: 20.5px;"),
      div(textOutput("frac10"), style = "margin-bottom: 20.5px;")
      
    ),
    
    tags$div(
    style = "display: flex; flex-direction: column;",
    progressBar(id = "progress1", value = 0, display_pct = TRUE, status = "success"),
    progressBar(id = "progress2", value = 0, display_pct = TRUE, status = "success"),
    progressBar(id = "progress3", value = 0, display_pct = TRUE, status = "success"),
    progressBar(id = "progress4", value = 0, display_pct = TRUE, status = "success"),
    progressBar(id = "progress5", value = 0, display_pct = TRUE, status = "success"),
    progressBar(id = "progress6", value = 0, display_pct = TRUE, status = "success"),
    progressBar(id = "progress7", value = 0, display_pct = TRUE, status = "success"),
    progressBar(id = "progress8", value = 0, display_pct = TRUE, status = "success"),
    progressBar(id = "progress9", value = 0, display_pct = TRUE, status = "success"),
    progressBar(id = "progress10", value = 0, display_pct = TRUE, status = "success")
    )
  )
  
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
  content = div(id="content", sidebar_fake, leafletOutput('map', height = "100%")),
  footer = footer
)
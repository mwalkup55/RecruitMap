library(leaflet)

df <- read.csv("data/data_flat.csv")
shinyUI(fluidPage(
  tags$head(tags$link(rel='stylesheet', type='text/css', href='styles.css')),
  
  titlePanel("Where do Colleges Recruit?"),
  
  leafletOutput('myMap',height = "400"),
  
  absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                draggable = TRUE, top = 80, left = "auto", right = 30, bottom = "auto",
                width = 300, height = 75,
                selectInput("teamChooser", 
                            label = "Choose a Team",
                            choices = sort(unique(as.character(df$college))),
                            selected = "Stanford")
  )
))
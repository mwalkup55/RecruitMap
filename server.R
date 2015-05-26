library(leaflet)
library(shiny)

df <- read.csv("data/data_flat.csv")
df$logo<-as.character(df$logo)

shinyServer(
  function(input, output) {
    
    map <- leaflet() %>% addTiles(urlTemplate = "http://{s}.tile.stamen.com/toner-lite/{z}/{x}/{y}.png", attribution = NULL) %>% setView(lng = -98, lat = 39, zoom = 4)
    
    mf <- reactive({
      df_sub<-df[df$college==as.character(input$teamChooser),]
      for(i in 1:nrow(df_sub)){
        map <- map %>% addPolylines(lng = c(df_sub$lon_hs[i],df_sub$lon_col[i]), lat = c(df_sub$lat_hs[i],df_sub$lat_col[i]),popup = df_sub$name[i],weight = 3, color = 'firebrick')
      }
      map %>% addMarkers(lng=df_sub$lon_col[1], 
                                lat=df_sub$lat_col[1],
                                icon = list(iconUrl = df_sub$logo[1], iconSize = c(40, 40)))
    })
    
    output$myMap <- renderLeaflet(mf()) 
  }
)
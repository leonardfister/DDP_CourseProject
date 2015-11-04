# load libraries shiny & jpeg
library(shiny)
library(googleVis)
library(jpeg)

# load the earth quake data, load map of fiji
data(quakes)
fiji <- readJPEG("www/fiji-map.jpg",native=TRUE)

# server function for shiny
shinyServer( function(input, output) {

        fit <- lm(mag ~ lat+long, data=quakes)
    pred <- function(lat, long){
        predict(fit, data.frame(lat=lat,long=long))
    }
    
    fctOnMap <- function(lat,long){
        x <- if( (-20<lat) & (lat<-16)& (177<long) & (long<182) )
                {" "} else { "(coordinates not on map)" }
        x
    }
    
    output$lat <- renderText({input$latitude})
    output$long <- renderText({input$longitude})
    output$onMap <- renderText({fctOnMap(input$latitude,input$longitude)})
    output$pred <- renderText({
        paste0("longitude = ", input$longitude,
               "°, latitude = ", input$latitude,
               "°, magnitude = ", round(pred(input$latitude,input$longitude),2)," (Richter)")})
    output$plot <- renderPlot({
        plot(x=seq(176.5,182.5,length=20),y=seq(-20.5,-15.5,length=20),
             type="n",
             xlab = "longitude (°)", ylab="latitude (°)")
        rasterImage(fiji,177,-20,181.95,-16)
        points(x=input$longitude,y=input$latitude,pch=19,cex=2,col=rgb(0,.4,0))
        text(x=input$longitude +.5,y=input$latitude +.5, 
             labels = paste0("magnitude = ", as.character(round(pred(input$latitude,input$longitude),2))))
    })
    
    output$map <- renderGvis({
        predpoint <- reactive({data.frame("latlong"=paste0(input$latitude,":",input$longitude),
                                          "magnitude"=pred(input$latitude,input$longitude))})
        gvisGeoMap(predpoint(), locationvar = "latlong", numvar="magnitude", 
                   options = list(width=400, height=300, dataMode="markers",region="009",showLegend=FALSE))
    })

} )

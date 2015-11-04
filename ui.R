library(shiny)
library(googleVis)
shinyUI(pageWithSidebar(
    headerPanel(h1("Fiji Earth Quakes"),
                list(tags$head(tags$style("body {background-color: #D8F6CE; }")))),
    sidebarPanel(
        h2("Documentation"),
        h4("Description"),
        h6("This application predicts the magnitude of earth quakes 
           in the area of Fiji islands. The computation is based on 
           the dataset \"quakes\" in the R datasets package."),
        h4("Usage"),
        h6("The prediction algorithm takes the longitude and latitude 
           as predictors in a linear regression model to predict the magnitude 
           of earth quakes at a given location. Below, the respective 
           values for the location to be predicted have to be adjusted by 
           the sliders. Minimal and maximal values are chosen such that they lie 
           within the original data. By clicking on the button \"Predict!\" the 
           computations and illustrations can be updated."),
        h4("Results"),
        h6("Results are given on the right hand side, summarizing the longitude 
           and latitude again and giving the estimated value for the magnitude 
           of the earth quake on the Richter scale."),
        h6("Below the numerical results, the location is illustrated on two maps. First, 
           on a zoomed map of Fiji (note that the predicted location may 
           not lie on this clipped map), and on a googleVis geographical map showing the 
           entire region of Oceania. (note pale colors)"),
        h2("Prediction of Magnitude"),
        sliderInput(inputId = "latitude", 
                    label="latitude", 
                    min=-38.59, max=-10.72, value=-18., step = .05),
        sliderInput(inputId = "longitude", 
                    label="longitude", 
                    min=165.67, max=188.13, value=178, step = .05),
        submitButton("Predict!"),
        width = 5
    ),
    mainPanel(
        h4("Results of Prediction:"),
        textOutput("pred"),
        h4(textOutput("onMap")),
        plotOutput("plot",width = "400px", height = "400px"),
        htmlOutput("map"),
        h5("note the paleness of gvisGeoMap colors, dependent on the screen (settings) it may not be displayed well "),
        width = 5
    )
))

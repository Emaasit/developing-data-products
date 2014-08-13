library(shiny)
library(datasets)
# load USArrests dataset from the datasets library
crimes <-data.frame(state = tolower(rownames(USArrests)), USArrests)
# create a dataframe of state coordinates
states_map <-map_data("state")

library(ggplot2)
# load helpers script that contains main mapping function, ratemap
source("helpers.R")

shinyServer(function(input, output){
    
    # create reactive map that changes based on live user input
    output$map <- renderPlot({
        data <- switch(input$var,
                        "Assault" = crimes[,c("state", "Assault")],
                        "Murder" = crimes[,c("state", "Murder")],
                        "Rape" = crimes[,c("state", "Rape")])
        values <- switch(input$var,
                         "Assault" = crimes$Assault,
                         "Murder" = crimes$Murder,
                         "Rape" = crimes$Rape)
        color <- switch(input$var,
                        "Assault" = "darkgreen",
                        "Murder" = "red",
                        "Rape" = "darkviolet")
        
        # call to main mapping function, ratemap
        ratemap(data, values, color)
    })
})

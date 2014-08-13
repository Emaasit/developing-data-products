# ui.R
# simple user interface for getting user input on his/her desired
# violent crime to display as a choropleth map of the United States.

shinyUI(fluidPage(
    titlePanel("Violent Crime Rates by U.S. State"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Compare violent crime rates for assault, murder, 
                     and rape in each of the 50 U.S. states in 1973."),
            
            # selectInput widget for getting user input
            selectInput("var", 
                        label="Choose a violent crime to display",
                        choices=c("Assault",
                                  "Murder",
                                  "Rape"),
                        selected="Assault")
        ),
        
        # output choropleth map based on user input
        mainPanel(plotOutput("map"))
    )
))

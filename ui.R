library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("Iris Species Predictor"),
    sidebarPanel(
        numericInput('length', 'Petal length', 0, min = 1, max = 7, step = 0.5),
        numericInput('width', 'Petal width', 0.1, min = 0.1, max = 2.5, step = 0.1),
        submitButton('Submit')
        ),
    mainPanel(
        h3('Results of Prediction'),
        h4('Your petal length'),
        verbatimTextOutput("inputValue1"),
        h4('Your petal width'),
        verbatimTextOutput("inputValue2"),
        verbatimTextOutput("prediction")
        )
    )
)

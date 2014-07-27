library(shiny)
library(rpart)
library(caret)
data(iris)

irisPredict <- function(length, width) {
    inTrain <- createDataPartition(iris$Species, p=0.75, list = FALSE)
    training <- iris[inTrain,]
    testing <- iris[-inTrain,]
    
    modelFit <- train(training$Species~., method='rpart', data=training)
    testSet <- data.frame(Sepal.Length=0, Sepal.Width=0, Petal.Length=length, Petal.Width=width)
    predict(modelFit, testSet)
}

shinyServer(
    function(input, output){
        output$inputValue1 <- renderPrint({input$length})
        output$inputValue2 <- renderPrint({input$width})
        output$prediction <- renderPrint({irisPredict(input$length, input$width)})
    }
)

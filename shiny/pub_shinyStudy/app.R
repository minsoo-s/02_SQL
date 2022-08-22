library(shiny)
library(ggplot2)
library(gapminder)

ui <- fluidPage(
plotOutput("plot", click = "plot_click"),
tableOutput("data")
)

server<-function(input,output){
    output$plot <-renderplot({
        
    })
}
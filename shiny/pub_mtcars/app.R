# [ mtcars ]
# ----------------------------------------------------
mpgData <-mtcars
mpgData$am <- factor(mpgData$am,
                        labels = c("Automatic", "Manual"))
library(shiny)

ui <- pageWithSidebar(

    #헤드패널
    headerPanel(
        h1("Miles Per Gallon")
    ),

    #사이드바패널
    sidebarPanel(
        selectInput("variable", "선택해봐봐",
                    list('실린더' = "cyl",
                        "트랜스미션" = "am",
                        "기억" = "gear")
        checkboxInput("outliers", "이상치 보여줌?",
                        FALSE)
        )
    ),

    #메인패널
    mainPanel(
        h3("포뮬러: "),
        h3(textOutput("caption")),
        plotOutput("mpgPlot")
    )
)

server <- function(input, output){

    formulaText <- reactive({
        paste("mpg ~ ", input$variable)
    })

    output$caption <- renderText({
        formulaText()
    })

    output$Plot <- renderPlot({
        boxplot(as.formula((formulaText())),
        data = mpgData,
        col = 'tomato'
        outline = input$ourliers)
    })
}

shinyApp(ui, server)

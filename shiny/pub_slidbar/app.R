# [ pageWithSidebar ]
# --------------------------------------------------
library(shiny)

ui <- pageWithSidebar(

    # 1. 헤더 패널
    headerPanel(
        h1("일반곰 여기 모여라.")),

    # 2. 사이드바 패널
    sidebarPanel(
        sliderInput("count", "니가 원하는 게 얼마나?",
            min = 1, max =10000, value = 5000)
            ),

    # 3. 메인 패널
    mainPanel(
        h3('니가 원하느 그림이 이거냐?')
        plotOutput("distPlot")
    )
)

server <- function(input, output) {
    output$distPlot <- renderPlot({
        dist <- rnorm(input$count)
        hist(dist, col = "steelblue", breaks = 50)
})
}

shinyApp(ui = ui, server = server)
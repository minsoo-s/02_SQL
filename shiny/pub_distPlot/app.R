# [ pageWithSidebar ]
# --------------------------------------------------
library(shiny)
library(gapminder)
library(ggplot2)

ui <- fluidPage(

    # 1. 헤더 패널
    headerPanel(
        h1("일반곰 여기 모여라.")),

    # 2. 사이드바 패널
    sidebarPanel(
        selectInput("year", "몇 년도 보여줄까?",
            seq(1952, 2007, 5))
            ),

    # 3. 메인 패널
    mainPanel(
        h3('해당 연도의 GDP 대비 기대수명 그래프입니다.'),
        plotOutput("distPlot")
    )
)

server <- function(input, output) {

    output$distPlot <- renderPlot({
        #year <- as.integer(get(input$year)),
        ggplot(subset(gapminder,year == input$year),
            aes(gdpPercap, lifeExp)) +
            geom_point(aes(color = continent)) +
            scale_x_log10() +
            geom_smooth()
    })
}

shinyApp(ui = ui, server = server)
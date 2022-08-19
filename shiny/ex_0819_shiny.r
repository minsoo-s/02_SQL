# [ shiny ] _ 2022.08.19.(금)
# -------------------------------------------------
library(shiny)

ui <- fluidPage(
    tags$h1("hello world"),  # html문법($ -> 마크다운 #역할)
    tags$img(src="https://img.hankyung.com/photo/201910/PCM20190502000402370_P2.jpg")
)

server <- function(input, output){

}

shinyApp(ui = ui, server = server)


# ---------------------------------------------------
ui <- fluidPage(
    tags$h1("자, 이제 너의 선택을 보여줘!"),

    selectInput("dataset", label = "골라",
                choices = c("iris", "mtcars", "state.x77")),

    tableOutput("table"),

    verbatimTextOutput("summary")
)

server <- function(input, output){

    dataset <- reactive({
        get(input$dataset, "package:datasets")
    })

    output$summary <- renderPrint({
        summary(dataset())
    })
# summary가 output의 입력이 됨.

    output$table <- renderTable({
        cat(input$dataset, "/n") # 디버깅용 출력
        head(dataset(),5)
# 테이블이란 이름으로 데이터셋 데이터 줌.
    })
}

shinyApp(ui, server)

# [ shiny plot ]
# -----------------------------------------------------
library(gapminder)
library(ggplot2)

ui <- fluidPage(
    tags$h1("갭마인더 따라해보기"),

    tags$h2("이것은 그림 그리기 "),
    plotOutput("plot", click = "plot_click"),

    tags$h3("이것은 사용자 클릭에 반응하기"),
    tableOutput("data")
)

server <- function(input, output){

    output$plot <- renderPlot({
        ggplot(subset(gapminder,year == 2007), aes(x = gdpPercap, y= lifeExp)) +
            geom_point(aes(color = continent)) +
            scale_x_log10() +
            geom_smooth()
    })

    output$data <- renderTable({
        req(input$plot_click)
        nearPoints(gapminder, input$plot_click)
    })
}

shinyApp(ui,server)

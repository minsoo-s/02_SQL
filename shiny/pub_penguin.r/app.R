# [ shiny summary2 ] palmerpenguin
# ----------------------------------------------------
library(shiny)
library(palmerpenguins)

pg <- penguins
pg <- pg[complete.cases(pg), ]
str(pg)

ui <- pageWithSidebar(

    #헤드패널
    headerPanel(
        h1(" 팔머펭귄 데이터셋")
    ),

    #사이드바패널
    sidebarPanel(
        checkboxInput("outliers", "이상치 보여줌?",
                        FALSE),

        selectInput("indvar", "선택해봐봐",
                    list("종류별" = "species",
                        "섬별" = "island",
                        "성별" = "sex")),

        selectInput("depvar", "종속 변수는?",
                    list("부리 길이" = "bill_length_mm",
                        "부리 깊이" = "bill_depth_mm",
                        "날개 길이" = "flipper_length_mm",
                        "체질량" = "body_mass_g")),

    ),

    #메인패널
    mainPanel(
        h3("포뮬러: "),
        h3(textOutput("caption")),
        plotOutput("penguinPlot")
    )
)

server <- function(input, output) {

    formulaText <- reactive({
        paste(input$depvar, "~", input$indvar)
    })

    output$caption <- renderText({
        formulaText()
    })

    output$penguinPlot <- renderPlot({
        boxplot(as.formula(formulaText()),
            data <- pg,
            col = "tomato",
            outline = input$outliers)
    })
}

shinyApp(ui, server)

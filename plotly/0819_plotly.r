# install.packages('plotly')
library(plotly)
library(ggplot2)
library(gapminder)

data(sleep)
sleep %>%
    plot_ly() %>%
    add_trace(x = ~ID,
            y = ~extra,
            type = "bar") %>%
    layout(title = "Bar Plot",
        xaxis = list(title = "Species"),
        yaxis = list(title = "Frequency"))

penguins |>
    plot_ly(x = ~ bill_length_mm,
            y = ~ bill_depth_mm,
            name = ~ species,
            hovertext = ~ island,
            hoverinfo = 'x + y + name + text')

# [ 실습 ]
# -------------------------------------------------------
# x축은 gdpPercap, y축은 lifeExp
# hover는 국가, 인구가 나타나도록
str(gapminder)
gapminder %>%
    plot_ly(x = ~ gdpPercap,
            y = ~ lifeExp,
            name = ~ country,
            hovertext = ~ pop,
            hoverinfo = 'x + y + name + hovertext ')

#install.packages('tidyverse')

# [ 시각화가 필요한 이유 ]
# ------------------------------------------------

library(tidyverse)

str(diamonds)
str(mpg)

ans <- anscombe

mean(ans$x1)
mean(ans$x2)
mean(ans$x3)
mean(ans$x4)

mean(ans$x1)
mean(ans$x2)
mean(ans$x3)
mean(ans$x4)

cor(ans$x1, ans$y1)
cor(ans$x2, ans$y2)
cor(ans$x3, ans$y3)
cor(ans$x4, ans$y4)

lm(y1 ~ x1, data = ans)
lm(y2 ~ x2, data = ans)
lm(y3 ~ x3, data = ans)
lm(y4 ~ x4, data = ans)

# 시각화 하기 전에는 차이점을 알기 어려움
# 아래 시작화를 통해 차이점을 명확히 인지할 수 있음.
par(mfrow = c(2,2))

plot(ans$x1, ans$y1, col='tomato', pch=19)
abline(lm(y1~x1, data = ans), col ='skyblue',lwd=3)

plot(ans$x2, ans$y2, col='tomato', pch=19)
abline(lm(y2~x2, data = ans), col ='skyblue',lwd=3)

plot(ans$x3, ans$y3, col='tomato', pch=19)
abline(lm(y3~x3, data = ans), col ='skyblue',lwd=3)

plot(ans$x4, ans$y4, col='tomato', pch=19)
abline(lm(y4~x4, data = ans), col ='skyblue',lwd=3)
par(mfrow = c(1,1))


# [ ggplot 배우기 ]-------------------------------------------------
# 함수 합성을 통해 구현

ggplot(
        data = mpg,
        mapping = aes(x = displ, y = hwy)) +
    geom_point() # 산점도

# 변수로 저장해서 함수를 합성할 수 있음.
p <- ggplot(
        data = mpg,
        mapping = aes(x = displ, y = hwy))

# P의 그래프 종류 선택 함수에서도 컬러 적용 가능.
# color = 변수명을 넣으면 자동 구분에서 컬러 적용됨.
table(mpg$class)
p + geom_point(mapping = aes(color = class,
                            shape = class))

p + geom_point(mapping = aes(color = class,
                            size = class,
                            alpha = 0.3))

p + geom_point(color = 'tomato') +
    facet_wrap(~class, nrow =3)

p + geom_point(color = 'tomato') +
    facet_grid(drv ~ cyl)

p + geom_point(mapping = aes(color = 'tomato')) +
    geom_smooth(color = "orange")


# [ diamond 실습 - bar ]--------------------------------------------
table(diamonds$cut)
p <- ggplot(data = diamonds,
            mapping = aes(x = cut))

# diamond$cut 데이터는 y가 없어서 그릴 수 없음.
p + geom_point()

# geom_bar는 알아서 그려줌.
p + geom_bar() # p + stat_count()

# 범주별 누적 count
p + geom_bar(mapping = aes(fill = clarity))

# 범주별 누적비율 : 0~1 안에서 비율
p + geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position =  "fill")

# 범주별 count (누적X)
p + geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position =  "dodge")


# [ 데이터 사우르스 ] ---------------------------------------------
# install.packages('datasauRus')
library(datasauRus)

#data(package = 'datasauRus')
dd <- datasaurus_dozen

str(dd)
unique(dd$dataset)

# plot이용해서 dino 그리기 
plot(y ~ x,
    data = subset(dd, dataset == 'dino'),
    pch = 19, col = 'tomato')

# ggplot이용 dino 그리기
ggplot(
    data = subset(dd, dataset =='dino'),
    mapping = aes(x = x, y = y)) +
geom_point(color = '#03445e')

# ggplot이용 dataset 모두 그리기
ggplot(
    data = dd,
    mapping = aes(x = x, y = y)) +
geom_point(mapping = aes(color = dataset)) +
facet_wrap(~ dataset, nrow = 4)

# ggplot이용 boxplot 그리기
p <- ggplot(mpg, aes(x = class, y = hwy))
p + geom_boxplot(fill = "tomato")

p <- ggplot(diamonds, aes(x = cut, fill = cut))
p + geom_bar(show.legend = F, width = 1) + coord_polar()


# [ map_Data ]
# ---------------------------------------------------
# install.packages("maps")
library(maps)
world <- map_data("world")
ggplot(world, aes(long, lat, group = group)) +
    geom_polygon(fill = 'skyblue', color ='blue')


# [ 파이프라인 %>% ]
# -----------------------------------------------
str(mpg)
df <- mpg[mpg$hwy > mean(mpg$hwy),c(1,2,9,11)]
sd(df$hwy)

best.in.class <- mpg %>% 
    group_by(class) %>% # group_by(mpg, class)
    filter(row_number(desc(hwy)) == 1)

p <- ggplot(
    data = mpg,
    mapping = aes(x = displ, y = hwy))

p + geom_point(mapping = aes(color = class)) +
    geom_label(
        mapping = aes(label = model),
        data = best.in.class,
        nudge_y = 2,
        alpha = 0.5) +
    theme(legend.position = "top") +
    theme_minimal()


# [ 이미지 저장하기 ]
# ------------------------------------------------
getwd()
ggsave("./ggplot.png", 
    width = 1920, height = 1080, units = "px")
ggsave("./ggplot.pdf",
    width = 1920, height = 1080, units = "px")


# [ Several histograms on the same axis ]
# ------------------------------------------------
# library
library(ggplot2)
library(dplyr)
library(hrbrthemes)
# 패키지 설치 안되면 mamba install r- [패키지명]

# Build dataset with different distributions
data <- data.frame(
    type = c(rep("variable 1", 1000), 
            rep("variable 2", 1000) ),
    value = c( rnorm(1000), 
                rnorm(1000, mean=4) )
)

# Represent it
p <- data %>%
    ggplot( aes(x=value, fill=type)) +
    geom_histogram( color="#e9ecef", alpha=0.6, position = 'identity') +
    scale_fill_manual(values=c("#69b3a2", "#404080")) +
    theme_ipsum() +
    labs(fill="")


# [ 펭귄 데이터로 히스토그램 겹치기 실습 ]
# -----------------------------------------------------
# install.packages('palmerpenguins')
library(palmerpenguins)
pg <- penguins
pg <- pg[complete.cases(pg),]

pg %>%
    ggplot(aes(x=body_mass_g, fill=sex))+
    geom_histogram(color = "tomato", alpha=0.6, position = 'identity')
    scale_fill_manual(values=c('skyblue','orange'))+
    theme_ipsum() +
    labs(fill = "")


# [ gapminder ]
# ----------------------------------------------------
#install.packages('gapminder')
library(gapminder)
# install.packages('esquisse')
library(esquisse)
esquisse::esquisser()

library(ggplot2)

ggplot(gapminder::gapminder) +
 aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop) +
 geom_point(shape = "circle") +
 scale_color_hue(direction = 1) +
 theme_minimal() +
 facet_wrap(vars(year))

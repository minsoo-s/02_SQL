data(iris)
iris
iris_t <- table(iris$Sepal.Length,iris$Sepal.Width)

# 행별(1) or 열별(2) 총합만 구하기 
margin.table(iris_t,1) # 테이블 넣어줘야함.

# 행 기준(1) or 열 기준(2) 비율을 구해줌
prop.table(iris_t,1)

# 열 기준(1) or 행 기준(2) 행/열별 총합 및 각 해당 값도 보여줌.
addmargins(iris_t,margin=2)

# t.test (수치형 변수 ~ 범주형변수(범주 2개여야함))
install.packages('vcd')

# package 정보 확인방법----------------------------------------------------
# 해당 package 정보 확인
library(help=vcd)
# 전체 라이브러리 확인
library()
# 해당 데이터셋 확인
?mtcars
#--------------------------------------------------------------------------

library(vcd) # vcd 패키지:Arthritis 데이터셋
str(Arthritis)
cross.tab <- with(Arthritis, table(Improved, Treatment))
iris
t.test(Arthritis$ID~Arthritis$Treatment, conf.level=0.95)

# plot, lm, abline
plot(mtcars$mpg~mtcars$wt,
     col='tomato',
     pch=19)
x <- lm(mpg~wt,data=mtcars)
x
abline(x,col='skyblue',lwd=3)

# summary에서 Median과 Mean이 가까울수록 정규분포에 근사
# 반대로 멀면 왜도가 크다고 할 수 있다.

windows(width = 7, height = 5)

# 0,5확률를 100개 10번 던져보기
v <- rbinom(n=10, size=100, prob=0.4)
hist(v,col = 'orange', breaks=20)

set.seed(2022)
v <- runif(n = 100000, min = 0, max = 100)
hist(v,col='tomato', breaks=20)

mean(v)
sd(v)

v <- rnorm(n=10000, mean = 50, sd=20)
hist(v, col='violet', breaks=20)

x <- seq(0,100,length = 100)
y <- dnorm(x,mean=50,sd=20)
plot(x,y,type='l',
     col='tomato', lwd =3 )

x <- seq(0,100,length = 100)
y <- dunif(x,min=0,max=100)
plot(x,y,type='l',
     col='tomato', lwd =3 )

x <- seq(140,200,length = 100)
y <- dnorm(x,mean=170,sd=10)
plot(x,y,type='l',
     col='tomato', lwd =3 )

#연습문제 

x <- seq(10000,50000,length=200)
y <- dnorm(x,mean =30000, sd=10000)
plot(x,y, type='l',
     col='tomato',lwd=3)

#누적값
pnorm(35000,30000,10000)
pnorm(25000,30000,10000)
pnorm(35000,30000,10000)-pnorm(25000,30000,10000)

# 평균에서 분산 +-1범위에 68% 존재
pnorm(1)-pnorm(-1)
pnorm(1,0,1)-pnorm(-1,0,1)
# 평균에서 분산 +-2범위에 95% 존재
pnorm(2,0,1)-pnorm(-2,0,1)
# 평균에서 분산 +-2.56범위에 99% 존재
pnorm(2.56)-pnorm(-2.56)

#학생 100명일 때 내 등수 계산(평균 68점, 분산 10)
pnorm(87, mean = 68,sd = 10)
(1-pnorm(87, mean = 68,sd = 10))*100

# lower.tail 순서 뒤집기
pnorm(87, mean = 68,sd = 10,lower.tail = F)

pnorm(70,60,10, lower.tail = F)
pnorm(80,70,20, lower.tail = F)


x <- rbinom(10000, size=100, prob=0.5)
hist(x,col='steelblue',breaks=20)
curve(dnorm(x,50,5), 30,37, col='tomato',
      add= T, lwd=3,lty=2)


# 분포종류 -> 유의수준 설정 -> 95% 밖에 있으면 유의미

# 실습-------------------------------------
library(MASS)
height <- na.omit(survey$Height)
length(height)
hist(height,col='skyblue',breaks=20)

mean(height)
sd(height)

# 샘플링
X.bar <- c()
for (i in 1:10000){
  samp <- height[sample(1:209,size=30)]
  X.bar[i] <- mean(samp)
  X.sd[i] <- sd(samp) 
}
hist(X.bar, col='skyblue',
     breaks = 20, prob = T)
x <- seq(160,180,length = 200)
curve(dnorm(x,mean(height),sd(X.bar)), 
      160, 180, col='tomato',
      add= T, lwd=3, lty=2)

X.bar
X.sd



x.1 <- rnorm(n=5000, mean = 70, sd = 5)
x.2 <- rnorm(n=5000, mean = 50, sd = 5)
x <- c(x.1, x.2)
hist(x, col='skyblue',breaks=20)


X.bar <- c()
for (i in 1:10000){
  samp <- x[sample(x,size=30)]
  X.bar[i] <- mean(samp) 
  X.sd[i] <- sd(samp) 
}
hist(X.bar, col='skyblue',
     breaks = 20, prob = T)
x.samp <- seq(30,90,length = 200)
curve(dnorm(x.samp,mean(x),sd(X.bar)), 
      30, 90, col='tomato',
      add= T, lwd=3, lty=2)


cor(iris[,-5])

cor.test(iris$Petal.Width,iris$Petal.Length)

binom.test(x= 60, n = 100, p = 0.5)
qnorm(p = 0.5, mean = 50, sd = 10)
qnorm(p = 0.68, mean = 50, sd = 10)

qnorm(p = 0.975, mean = 50, sd = 10)
qnorm(p = 0.025, mean = 50, sd = 10)

qnorm(p = 0.005, mean = 50, sd = 10)
qnorm(p = 0.995, mean = 50, sd = 10)

# pnorm, qnorm 서로 구하는 관계
pnorm(75.75829, mean = 50, sd = 10)
pnorm(24.24171, mean = 50, sd = 10)
pnorm(69.59964, mean = 50, sd = 10)
pnorm(30.40036, mean = 50, sd = 10)

binom.test(x =65, n=100, p=0.5)

binom.test(x =60, n=100, p=0.5, conf.level=0.99)

# 정규성 테스트 (shapiro.test)
shapiro.test(survey$Height)
hist(survey$Height)

shapiro.test(survey$Age)
hist(survey$Age)

shapiro.test(iris$Petal.Length)
shapiro.test(mtcars$mpg)


qqnorm(survey$Height,col='skyblue')
qqline(survey$Height,col='tomato',lwd=3)

qqnorm(survey$Age,col='skyblue')
qqline(survey$Age,col='tomato',lwd=3)


df <- read.csv('../FirstMiniProject/HousePrices.csv')
shapiro.test(df$GarageArea)
shapiro.test(df$GarageCars)
shapiro.test(df$MSSubClass)
shapiro.test(df$OverallQual)

# df(degree of freedom) : 자유도
v <- rt(n =10000, df = 29) 
hist(v,col='steelblue', prob=T)

x <- seq(-4,4,length=200)
#자유도선그리기
curve(dt(x, df=29),min= -4,max = 4,
      add=T,
      col='tomato',lwd=3, lty=2)
#정규분포그리기
curve(dnorm(x),-4,4,
      add =T,
      col ='violet',lwd=5,lty=4)

# pt:누적분포함수(q확률변수, df자유도)
pt(q =2.04523, df=19)
pt(q =0.975, df=29)
# qt는 누적분포함수의 역함수
qt(p = 0.975, df=29)
qt(p = 0.995, df=29)


# t-test실습(종속:수치, 독립:범주) 
str(cats)

library(MASS)
table(cats$Sex)

mean(cats$Bwt)
tapply(cats$Bwt, 
       INDEX = list(Sex=cats$Sex), 
       mean)

# conf.level: 신뢰구간
t.test(Bwt~ Sex, data=cats,conf.level=0.99)

str(sleep)
t.test(extra~group, data =sleep, paired = T)






# 실습: 수면 
str(sleep)
head(sleep)

library(tidyr) # spread library
wide.df <- spread(sleep, key=group, value = extra)
summary(wide.df)

tapply(sleep$extra,
       INDEX = list(sleep$group),
       FUN = mean)

# 두 가지 방법
t.test(extra~group, data = sleep, paired =T)
t.test(wide.df$'1' , wide.df$'2', paired=T)


# 실습: 카이스퀘어
# -> 양측검정 불가능(평균비교가 아니기 때문)
windows(width=10,height=8)
v <- rchisq(n = 1000, df=1)
hist(v, col ='orange')

x <- seq(0,15,length=200)
x
curve(dchisq(x,df=1),0,15,
      col='tomato',lwd=2,lty=1)
curve(dchisq(x,df=5),0,15,
      col='skyblue',lwd=2,lty=1,
      add=T)
curve(dchisq(x,df=10),0,15,
      col='orange',lwd=2,lty=1,
      add=T)
curve(dchisq(x,df=199),0,15,
      col='green',lwd=2,lty=1,
      add=T)

# 카이스퀘어 value값 알아내기
qchisq(p=0.95,df=1) # x = 3.84정도에서 95%를 포함함.
pchisq(q=2.5,df=1) 
pchisq(q=3.84,df=1) 
pchisq(q=5,df=1, lower.tail = F) 

# 매트릭스 만들기
mt <- matrix(c(1443,151,47,1781,312,135), nrow=3)
class(mt)
mt

df <- data.frame(mt)
str(df)
colnames(df) <- c("With","Without")
rownames(df) <- c("경상","중상","사망")
df


oij <- c(1443,1781,151,312,47,135)
eij <- c(1367, 1855.9,196.9,267.4,77.1,104.7)
sum((oij-eij)^2/eij)


# 타이타닉 데이터셋 p-value 검정
Titanic
str(Titanic)
class(Titanic)

tb <- margin.table(Titanic,margin=c(4,1))
class(tb)
tb
chisq.test(tb)

tb <- margin.table(Titanic,margin=c(4,2))
chisq.test(tb)
tb

tb <- margin.table(Titanic,margin=c(4,3))
chisq.test(tb)



# 실습 : f분포

v <- rf(n=10000, df1=1, df2=30)
hist(v,col='steelblue')

x <- seq(0,15,lengt=20)
curve(df(x,df1=1, df2= 30),0,15,
      col="tomato",lwd=3,lyu=1)

curve(df(x,df1=5, df2= 50),0,15,
      col="steelblue",lwd=3,lyu=1,
      add = T)

curve(df(x,df1=1, df2= 80),0,15,
      col="orange",lwd=3,lyu=2,
      add=T)


qf(p = 0.95, df1=1, df2=30)
pf(q=4,17)


# 실습 : 스프레이
df <- InsectSprays
str(df)
table(df$spray)

round(tapply(df$count, 
       INDEX = list(df$spray),
       FUN=mean),3)
# 스프레이종류에따라 차이가 있어 보인다~

boxplot(df$count~df$spray,col=2:7)
# 군이 나뉘는 듯 보인다.

aov.result <- aov(count ~ spray, data=df) #분산분석
summary(aov.result)
# 일단 집단간의 분산에 따른 분석을 통해 차이가 있음.

TukeyHSD(aov.result)
# 사후분석: 구체적인 요소들의 관계 p-value



# 실습 
#install.packages('gplots')
windows(10,8)
library(gplots)
plotmeans(count~spray, data=df,
          col = 'tomato',barcol='orange',
          lwd=3, barwidth=3)

model.tables(aov.result, type = 'mean')
model.tables(aov.result, type = 'effect')

plot(TukeyHSD(aov.result),
     col='tomato',
     las= 1)

library(car)
qqPlot(df$count,pch=19, col='orange')

shapiro.test(df$count) # 정규분포를 따르지 않음을 알 수 있다.

# 레벤 검정이나 바틀렛 검정을 통해 집단 간 분산의 동일성 여부 검정
leveneTest(count ~ spray, data = df) # 등분산이 아니다 = 대립가설
bartlett.test(count ~ spray, data = df) # 등분산이 아니다 = 대립가설

oneway.test(count ~ spray, data = df)

df <- ToothGrowth
str(df)
unique(df$dose)
df$dose <- factor(ToothGrowth$dose, levels = c(0.5,1.0,2.0),
                  labels = c('L','M','H'))
str(df)

tapply(df$len, 
       INDEX = list(SUPP=df$supp, DOSE=df$dose),
       FUN =mean)
with(df, tapply(len, 
                INDEX = list(SUPP=supp, DOSE=dose),
                FUN =mean))

# 이원 분산 분석
# 아래 두 코드는 같은 의미
boxplot(len ~ supp*dose, data =df, col=c('tomato','orange'))
boxplot(len ~ supp+ dose + supp:dose, data =df, col=c('tomato','orange'))

# Y(종속) ~ X(독립) : 주효과
# Y(종속) ~ X1*X2   : 주효과 + 상호작용

aov.result <- aov(len~supp*dose, data=df)
summary(aov.result)

# 사후분석
TukeyHSD(aov.result)
plot(TukeyHSD(aov.result), las=1, col='red')



# 상관계수(3종류)
#install.packages('cats')
library(cats)
cats
cor(cats$Bwt, cats$Hwt, method='pearson')
cor(cats$Bwt, cats$Hwt, method='spearman')
cor(cats$Bwt, cats$Hwt, method='kendall')



# 회귀분석(Y(종속): 자녀키, X(독립: 부모키))
#install.packages('HistData')
library(HistData)
df <- GaltonFamilies
str(df)

windows(8,6)
cor(df$midparentHeight,df$childHeight)
plot(childHeight ~ midparentHeight, data = df,
     col = adjustcolor('steelblue', alpha = 0.5),
     pch = 19)

plot(jitter(childHeight) ~ jitter(midparentHeight), 
     data = df,
     col = adjustcolor('steelblue', alpha = 0.5),
     pch = 19)

# 선형 회귀식
model <- lm(childHeight~ midparentHeight,data= df)
abline(model, col ='tomato' ,lwd=3)

# x랜덤 생성
x <- runif(n=100, min = 0, max=100)
# y식 + 랜덤 추가
y <- 3*x +5 + rnorm(100,0,20)
# 데이터 하나씩 플랏
plot(x,y,pch =19, col = 'skyblue')

cor(x,y)
# 공식생성
lm(y~x)
# 선으로 그리기
model <- lm(y~x)
abline(model, col ='tomato', lwd=2)

summary(model)

# y = 1x+5
abline(a = 1, b =5, col ='red',
       lwd =1, lty =2)

#실습 prestige

library(car)
data(Prestige)
df <- Prestige
str(df)

table(df$type)

windows(8,6)
barplot(table(df$type), col ='orange')

# 히스토그램
hist(df$income, col = 'tomato', breaks=20)
hist(df$women, col = 'tomato', breaks=20)
hist(df$prestige, col = 'tomato', breaks=20)

# 정규분포 따르는지 확인
shapiro.test(df$income)
shapiro.test(df$women)
shapiro.test(df$prestige)

plot(df[, -(5:6)], col = 'skyblue')

# 선형 회구분석
lm(income ~ education, data = df)
cor(df[,-(5:6)])

# (intercept -> 절편, 값 -> 기울기)
model <- lm(income ~ education, data =df)
summary(model)

plot(income ~ education, data = df, 
     pch=19, col='skyblue')
abline(model, col = 'tomato', lwd=2)

# education,prestige 독립변수끼리 상관관계가 높아
# 동시에 pvalue를 확인하면 영향을 받는다.
model <- lm(income ~ education + women + prestige, 
            data = df)
summary(model)

model <- lm(income ~ education + women, 
            data = df)
summary(model)

model <- lm(income ~ education + prestige, 
            data = df)
summary(model)

model <- lm(income ~ prestige + women, 
            data = df)
summary(model)








# 다중 회구분석 
#install.packages('stargazer')
library(stargazer)
stargazer(model,type = 'text')

windows(8,6)
par(mfrow =c(2,2))
plot(model)
par(mfrow=c(1,1))

model <-  lm(income ~ education, data =df)
plot(income ~ education, data = df, col= 'skyblue',pch=19)

model <-  lm(income ~ education+ I(ecuation^2), data =df)
summary(model)
abline(model)
plot(income ~ education, data = df)

library(dplyr)
with(df,
     lines(arrange(data.frame(education, fitted(model)), 
                   education), 
           lty = 1, lwd = 3, col = "tomato"))
summary(model)     

install.packages('corrgram')
library(corrgram)
corrgram(df)

df <- mtcars[, 1:6]
df
lm(mpg ~ ., data =df)
model <- lm(mpg ~ ., data =df)
summary(model)

model <- lm(mpg ~ hp+ wt, data =df)
summary(model)

model <- lm(mpg ~ disp +drat + hp + wt,
            data =df)
mod.selected <- step(model, direction='backward')
mod.selected
summary(mod.selected)


# 연습문제 
# Kaggle House Price 데이터셋에서
# 다중 선형 회구의 변수 선택을 통해
# 최적의 독립 변수 조합을 찾아보시오.
# 1. 전진선택법으로 찾은 조합은? R2, Adjusted R2?
# 2. 후진선택법으로 찾은 조합은? R2, Adjusted R2?
# 상수항 선택법 : SalesPrice ~ 1
df <- read.csv('../FirstMiniProject/HousePrices.csv')
str(df)
df.lm <- lm(SalePrice~1,data=df)
mod.selected <- step(df.lm, direction='backward')

mod.selected <- step(lm(SalePrice~1,df), 
                     scope=list(lower=~1,upper=~SalePrice),
                     direction='backward')
summary(mod.selected)


# 교수님풀이

df <- read.csv('../FirstMiniProject/HousePrices.csv')
str(df)
dim(df)
is.num <- c()
for (i in 1:80){
  is.num[i] <- is.numeric(df[,i])
}
is.num
df <- df[,is.num]
df <- df[,-1]
dim(df)
df <- df[complete.cases(df),]
dim(df)
str(df)
model <- lm(SalePrice~., data =df)
summary(model)

mod.selected.back <- step(model, direction = 'backward')
summary(mod.selected.back)
mod.selected.forward <- step(model, direction = 'forward')
summary(mod.selected.forward)

# 범주형 
df <- InsectSprays
model <- lm(count~spray,df)
summary(model) 
str(df)
contrasts(df$spray)

df <- mtcars[,1:6]
str(df)

df$cyl <- factor(df$cyl)
head(df)
table(df$cyl)

model <- lm(mpg~.,data =df)
summary(model)



df <- split(iris,f = iris$Species)
df <- rbind(df$setosa, df$versicolor)
plot(df[,c(3,5)])

plot(iris[iris$Species,c(1,5)])
str(iris)


# 시그모이드 함수
# 로지스틱 함수
